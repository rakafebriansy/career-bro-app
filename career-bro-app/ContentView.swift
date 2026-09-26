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
            
            Tab(role: .search) {
                SearchView()
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
