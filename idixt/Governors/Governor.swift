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
    var userContext: UserContext = UserContext()
    var idixtContext: IdixtContext = IdixtContext()
    
    enum GenerationState { case idle, isRecording, isTyping, hasText, thinking, isGenerating }
    var genState: GenerationState = .idle
    var canRecord: Bool? = nil
    enum ApplicationMode: Identifiable {
        case archiveSheet, settingsSheet, aboutSheet
        var id: Self { self }
    }
    var mode: ApplicationMode? = nil
    enum AlertReport { case hardwareInsufficient, modelCreationFail, modelGenerationFail, recordingFail }
    var alertReport: AlertReport? = nil
    var alertText: String? = nil
    var introMode: Bool = false
    
    func makeAsk(idiot: IdixtModel) async {
        do {
            if introMode { try await Initialixt().setModel(gov: self, idiot: idiot) }
            genState = .thinking
            thread.exchange.append(input)
            let prompt = input
            input = ""
            try await idiot.generateReply(prompt: prompt, gov: self)
            if activeReply != nil { genState = .isGenerating }
            if activeReply != nil { print(activeReply!) }
            thread.exchange.append(activeReply ?? "thread has not finished generating")
            activeReply = ""
            genState = .idle
        } catch {
            genState = .idle
            alertText = "model generation failed: \(error)"
            alertReport = .modelGenerationFail
        }
    }
    
    private func compressContext(idiot: IdixtModel) async {
        Task {
            do {
                if thread.localContext.count > 2000 { thread.localContext = try await compress(thread.localContext) }
                if userContext.info.count > 1000 { userContext.info = try await compress(userContext.name) }
                if idixtContext.info.count > 1000 { idixtContext.info = try await compress(idixtContext.name) }
                func compress(_ string: String) async throws -> String {
                    return try await idiot.generateCondense(text: string)
                }
            }
        }
    }
}


