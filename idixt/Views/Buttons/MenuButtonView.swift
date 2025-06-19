//
//  MenuButtonView.swift
//  idixt
//
//  Created by Becket Bowes on 6/17/25.
//

import SwiftUI

struct MenuButtonView: View {
    @Binding var gov: Governor
    
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
        print("save thread")
        print("new session")
        gov.mode = nil
    }
}

#Preview {
    MenuButtonView(gov: .constant(Governor()))
}
