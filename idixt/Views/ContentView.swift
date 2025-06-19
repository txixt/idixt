//
//  ContentView.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var dataContext
    @Query private var threads: [Thread]
    @Query private var userContext: [UserContext]
    @Query private var idixtContext: [IdixtContext]
    @State var gov: Governor = Governor()
    @State var idiot: IdixtModel?
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color.gray.opacity(0.2).ignoresSafeArea()
                
                VStack {
                    ThreadView(gov: $gov).ignoresSafeArea()
                }
                .toolbar {
                    ToolbarItem(placement: .title) { TitleView(gov: $gov).glassEffect() }
                    ToolbarItem(placement: .bottomBar) { MenuButtonView(gov: $gov) }
                    ToolbarSpacer()
                    ToolbarItem(placement: .bottomBar) { TextEntryView(gov: $gov, idiot: $idiot) }
                    ToolbarSpacer()
                    ToolbarItem(placement: .bottomBar) { AskButtonView(gov: $gov, idiot: $idiot) }
                }
                .monospaced()
                .sheet(item: $gov.mode) { mode in
                      switch mode {
                      case .archiveSheet: ArchiveView(gov: $gov)
                      case .settingsSheet: SettingsView(gov: $gov)
                      case .aboutSheet: AboutView(gov: $gov)
                      }
                  }
                
                if gov.alertReport != nil {
                    AlertView(gov: $gov)
                }
                
            }
            .task { loadModels() }
        }
    }
    
    private func loadModels() {
        Task {
            if !userContext.isEmpty { gov.userContext = userContext.first }
            if !idixtContext.isEmpty { gov.idixtContext = idixtContext.first }
            let context = ContextCreator().create(user: gov.userContext, idixt: gov.idixtContext)
            idiot = IdixtModel(context: context)
            if threads.isEmpty {
                do {
                    try await IdixtManager.introduce(idiot: idiot, gov: gov)
                }
                dataContext.insert(gov.thread)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

//if #available(iOS 26, *) {
//
//}
//else {
//    ToolbarItem(placement: .title) { TitleView(gov: $gov) }
//}


//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
//
//    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }

