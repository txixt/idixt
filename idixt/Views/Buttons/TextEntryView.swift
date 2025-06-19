//
//  TextEntryView.swift
//  idixt
//
//  Created by Becket Chambliss on 6/17/25.
//

import SwiftUI

struct TextEntryView: View {
    @Binding var gov: Governor
    @Binding var idiot: IdixtModel?
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            TextField("hmm?", text: $gov.input)
                .padding(5)
                .focused($isFocused)
                .onChange(of: isFocused) { focused, _ in
                    if focused {
                        gov.genState = .isTyping
                    } else {
                        gov.genState = gov.input.isEmpty ? .idle : .hasText
                    }
                }
                .onSubmit {
                    Task {
                        guard let idiot else { return }
                        await gov.makeAsk(idiot: idiot)
                    }
                }
        }
    }
}

#Preview {
    TextEntryView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}

