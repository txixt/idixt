//
//  AskButtonView.swift
//  idixt
//
//  Created by Becket Bowes on 6/17/25.
//

import SwiftUI

struct AskButtonView: View {
    @Binding var gov: Governor
    @Binding var idiot: IdixtModel
    
    var body: some View {
        switch gov.genState {
        case .idle:
            Button(action: startRecording) { Image(systemName: "mic") }
        case .isRecording:
            Button(action: stopRecording) { Image(systemName: "stop") }
        case .isTyping:
            Button { Task { await gov.makeAsk(idiot: idiot) } } label: { Image(systemName: "arrow.up") }
        case .hasText:
            Button { Task { await gov.makeAsk(idiot: idiot) } } label: { Image(systemName: "arrow.up") }
        case .isGenerating:
            ProgressView()
        }
    }
    
    private func startRecording() {
        gov.genState = .isRecording
        gov.input = "Any time you want to finish implementing the recording code, i'd love to see it. No rush. This isn't at all embarassing"
    }
    
    private func stopRecording() {
        gov.genState = .hasText
    }
}

#Preview {
    AskButtonView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}
