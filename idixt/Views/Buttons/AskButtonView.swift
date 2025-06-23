//
//  AskButtonView.swift
//  idixt
//
//  Created by Becket Bowes on 6/17/25.
//

import SwiftUI
import SwiftData

struct AskButtonView: View {
    @Environment(\.modelContext) private var dataContext
    @Binding var gov: Governor
    @Binding var idiot: IdixtModel?
    @State var voiceToText: VoiceToText?
    
    var body: some View {
        
        if gov.canRecord == nil || gov.canRecord == true {
            Button(action: {
                switch gov.genState {
                case .idle:
                    Task { try await recordTheAsk() }
                case .isRecording: Task { try await writeThatAsk() }
                default:
                    Task { await makeTheAsk() }
                }
            }) {
                Image(systemName: gov.genState == .idle ? "mic" : gov.genState == .isRecording ? "stop" : "arrow.up")
            }
        } else {
            Button(action: { Task { await makeTheAsk() } }) {
                Image(systemName: "arrow.up")
            }
        }

    }
    
    private func toggleRecording() async {}
    
    private func makeTheAsk() async {
        guard let idiot else { return }
        do {
            try await idiot.generateReply(prompt: gov.input, gov: gov)
            dataContext.insert(gov.thread)
            dataContext.insert(gov.userContext)
            dataContext.insert(gov.idixtContext)
            try dataContext.save()
        }
        catch { gov.alertReport = .modelGenerationFail; gov.alertText = "model could not generate reply: \(error)" }
    }
    
    private func recordTheAsk() async throws {
        let voiceToText = VoiceToText()
        let error = voiceToText.start()
        if error != nil {
            gov.canRecord = voiceToText.isPermitted
            gov.alertText = error
            gov.alertReport = .recordingFail
        }
    }
    
    private func writeThatAsk() async throws {
        guard let voiceToText else { gov.genState = .idle; return }
        voiceToText.stop()
        gov.input = voiceToText.transcript
        await makeTheAsk()
    }
}

#Preview {
    AskButtonView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}
