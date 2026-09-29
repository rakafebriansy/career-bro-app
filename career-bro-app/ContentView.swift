//
//  ContentView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var router = AppNavigationRouter()

    var body: some View {
        TabView(selection: $router.selectedTab) {
            Tab("Home", systemImage: "house", value: 0) {
                HomeView()
            }

            Tab("Search", systemImage: "magnifyingglass", value: 1) {
                SearchView()
            }

            Tab("Robo", systemImage: "sparkles", value: 2) {
                RoboChatView()
            }

            Tab("Career DNA", systemImage: "map", value: 3) {
                CareerDNAView()
            }

            Tab("Profile", systemImage: "person", value: 4) {
                ProfileView()
            }
        }
        .environment(router)
    }
}

#Preview {
    ContentView()
        .modelContainer(SwiftDataSeeder.previewContainer)
}
