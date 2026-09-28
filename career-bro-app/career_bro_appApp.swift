//
//  career_bro_appApp.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import SwiftData

@main
struct career_bro_appApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: JobApplicationModel.self)
            SwiftDataSeeder.seedIfNeeded(context: container.mainContext)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
