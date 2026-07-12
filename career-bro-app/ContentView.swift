//
//  ContentView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 19/06/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ApplicationView()
                .tabItem {
                    Label("Application", systemImage: "briefcase")
                }
        }
    }
}

#Preview {
    ContentView()
}
