//
//  ContentView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            
            Tab("Application", systemImage: "briefcase") {
                ApplicationView()
            }
            
            Tab("Robo", systemImage: "sparkles") {
                RoboChatView()
            }
            
            Tab("Career DNA", systemImage: "map") {
                CareerDNAView()
            }
            
            Tab("Profile", systemImage: "person") {
                ProfileView()
            }
        }
    }
}

#Preview {
    ContentView()
}
