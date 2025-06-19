//
//  Governor.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import Foundation

@Observable final class Governor {
    var input: String = "" /*{ willSet { if !input.isEmpty { genState = .hasText; print("genState: \(genState)") } } }*/
    var activeReply: String = ""
    var thread: Thread = Thread()
    var userContext: UserContext? = nil
    var modelContext: ModelContext? = nil
    
    enum GenerationState { case idle, isRecording, isTyping, hasText, isGenerating }
    var genState: GenerationState = .idle
    enum ApplicationMode: Identifiable {
        case archiveSheet, settingsSheet, aboutSheet
        var id: Self { self }
    }
    var mode: ApplicationMode? = nil
    enum AlertReport { case hardwareInsufficient, modelCreationFail, modelGenerationFail }
    var alertReport: AlertReport? = nil
    var alertText: String? = nil
    
    func makeAsk(idiot: IdixtModel) async {
        do {
            genState = .isGenerating
            thread.exchange.append(input)
            let prompt = input
            input = ""
            activeReply = try await idiot.generateReply(prompt: prompt)
            thread.exchange.append(activeReply)
            if thread.exchange.count == 2 { await makeTitle(idiot: idiot) }
//
            
            activeReply = ""
            genState = .idle
        } catch {
            genState = .idle
            alertText = "model generation failed: \(error)"
            alertReport = .modelGenerationFail
        }
    }
    
    private func makeTitle(idiot: IdixtModel) async {
        do {
            thread.title = try await idiot.generateReply(prompt: "generate a two or three word summary for the current thread that started with the prompt: \(input)")
        } catch {
            thread.title = "thread for" + Date.now.description
        }
    }
    
//    private func makeContext(idiot: IdixtModel) async {
//        do {
//            thread.localContext = try await idiot.generateReply(prompt: "write a one or two paragraph summary of the conversation so far for yourself to refer to going forward")
//            print(thread.localContext)
//        } catch {
//            thread.localContext = "i can't remember what happened earlier in the conversation."
//            print(thread.localContext)
//        }
//    }
}
