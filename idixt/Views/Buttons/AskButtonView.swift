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
    
    var body: some View {
        Button(action: {
            switch gov.genState {
            case .idle, .isRecording:
                Task { await toggleRecording() }
            default:
                Task { await makeTheAsk() }
            }
        }) {
            Image(systemName: gov.genState == .idle ? "mic" : gov.genState == .isRecording ? "stop" : "arrow.up")
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
}

#Preview {
    AskButtonView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}
