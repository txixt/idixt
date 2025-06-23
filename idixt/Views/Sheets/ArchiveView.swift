//
//  ArchiveView.swift
//  idixt
//
//  Created by Becket on 6/18/25.
//

import SwiftUI
import SwiftData

struct ArchiveView: View {
    @Environment(\.modelContext) private var dataContext
    @Query private var threads: [Thread]
    @Binding var gov: Governor
    
    var body: some View {
        VStack {
            Text("Idixt Archive").font(.headline)
                .padding(.bottom)
            ScrollView {
                ForEach(threads) { thread in
                    HStack {
                        Button(action: { setChosenThread(thread) }) {
                            Text(thread.title)
                        }
                        .bold()
                        Spacer()
                    }
                    .padding()
                }
                .onDelete(perform: deleteChosenThreads)
            }
            Spacer()
            Button(action: { gov.mode = nil }) {
                Image(systemName: "xmark")
            }
            .buttonStyle(.glass)
        }
        .foregroundColor(.primary)
        .monospaced()
        .padding()
    }
    
    private func setChosenThread(_ chosenThread: Thread) {
        dataContext.insert(gov.thread)
        gov.thread = chosenThread
        gov.mode = nil
    }
    
    private func deleteChosenThreads(at offsets: IndexSet) {
        for index in offsets {
            let thread = threads[index]
            dataContext.delete(thread)
        }
    }
}

#Preview {
    ArchiveView(gov: .constant(Governor()))
}
