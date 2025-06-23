//
//  MenuButtonView.swift
//  idixt
//
//  Created by Becket Bowes on 6/17/25.
//

import SwiftUI
import SwiftData

struct MenuButtonView: View {
    @Environment(\.modelContext) private var dataContext
    @Query private var threads: [Thread]
    @Binding var gov: Governor
    @Binding var idiot: IdixtModel?
    @State private var showMenu: Bool = false
    
    var body: some View {
        Menu {
            Button(action: newThread) {
                HStack {
                    Image(systemName: "plus")
                    Spacer()
                    Text("New Thread")
                }
                .bold().monospaced()
            }
            Divider()
            Button(action: { gov.mode = .archiveSheet }) {
                HStack {
                    Image(systemName: "archivebox")
                    Spacer()
                    Text("Archived Threads")
                }
                .bold().monospaced()
            }
            Divider()
            Button(action: { gov.mode = .settingsSheet }) {
                HStack {
                    Image(systemName: "gear")
                    Spacer()
                    Text("Settings")
                }
                .bold().monospaced()
            }
            Divider()
            Button(action: { gov.mode = .aboutSheet }) {
                HStack {
                    Image(systemName: "info")
                    Spacer()
                    Text("About")
                }
                .bold().monospaced()
            }
        } label: {
            Image(systemName: "line.3.horizontal")
        }
    }
    
    private func newThread() {
        guard let idiot else { return }
        if !gov.thread.exchange.isEmpty { dataContext.insert(gov.thread) }
        gov.thread = Thread()
        let context = ContextCreator().create(user: gov.userContext, idixt: gov.idixtContext)
        idiot.reset(context: context)
        gov.mode = nil
        showMenu = false
    }
}

#Preview {
    MenuButtonView(gov: .constant(Governor()), idiot: .constant(IdixtModel()))
}
