//
//  Governor.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import Foundation

@Observable final class Governor {
    var input: String = ""
    var activeReply: String? = nil
    var thread: Thread = Thread()
    var userContext: UserContext? = nil
    var idixtContext: IdixtContext? = nil
    
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
    var introMode: Bool = false
    
    func makeAsk(idiot: IdixtModel) async {
        do {
            if introMode { try await IntroManager().followUpIntro(idiot: idiot, gov: self) }
            genState = .isGenerating
            thread.exchange.append(input)
            let prompt = input
            input = ""
            try await idiot.generateReply(prompt: prompt, gov: self)
            thread.exchange.append(activeReply ?? "thread has not finished generating")
            if thread.exchange.count == 2 { await makeTitle(idiot: idiot, prompt: prompt) }
            activeReply = ""
            genState = .idle
        } catch {
            genState = .idle
            alertText = "model generation failed: \(error)"
            alertReport = .modelGenerationFail
        }
    }
    
    private func makeTitle(idiot: IdixtModel, prompt: String) async {
        do {
            try await idiot.generateTitle(prompt: prompt, gov: self)
        } catch {
            thread.title = "thread for" + Date.now.description
        }
    }
    
    private func compressContext(idiot: IdixtModel) async {
        Task {
            do {
                if thread.localContext.count > 500 { thread.localContext = try await compress(thread.localContext) }
                if userContext != nil && userContext!.info.count > 500 { userContext!.info = try await compress(userContext!.name) }
                if idixtContext != nil && idixtContext!.info.count > 500 { idixtContext!.info = try await compress(idixtContext!.name) }
                func compress(_ string: String) async throws -> String {
                    return try await idiot.generateCondense(text: string)
                }
            }
        }
    }
}


