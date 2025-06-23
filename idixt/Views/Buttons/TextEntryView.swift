//
//  TextEntryView.swift
//  idixt
//
//  Created by Becket Chambliss on 6/17/25.
//

import SwiftUI
import SwiftData

struct TextEntryView: View {
    @Environment(\.modelContext) private var dataContext
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
                        idiot?.prewarm()
                    } else {
                        gov.genState = gov.input.isEmpty ? .idle : .hasText
                    }
                }
                .onSubmit {
                    Task {
                        guard let idiot else { return }
                        await gov.makeAsk(idiot: idiot)
                        dataContext.insert(gov.thread)
                        dataContext.insert(gov.userContext)
                        dataContext.insert(gov.idixtContext)
                        try dataContext.save()
                    }
                }
                .submitLabel(.send)
        }
    }
}

#Preview {
    TextEntryView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}
