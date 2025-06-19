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
    
    private func makeTheAsk() async {}
}

#Preview {
    AskButtonView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}
