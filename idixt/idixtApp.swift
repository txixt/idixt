//
//  idixtApp.swift
//  idixt
//
//  Created by Becket on 6/17/25.
//

import SwiftUI
import SwiftData

@main
struct idixtApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Thread.self,
            UserContext.self,
            IdixtContext.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
