import SwiftUI

struct ProfileView: View {
    @State private var isNotificationEnabled: Bool = true
    @State private var showLogoutConfirmation: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color(hex: "2563EB")
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 120)
                
                VStack(spacing: 0) {
                    headerBar
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            ProfileHeaderCardView(
                                name: "Raka Febrian",
                                email: "wildanajii@gmail.com",
                                onEditTapped: {
                                }
                            )
                            
                            settingsSection
                            
                            securitySection
                            
                            ProfileLogoutButtonView {
                                showLogoutConfirmation = true
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 12)
                        .padding(.bottom, 32)
                    }
                    .background(Color(hex: "F8FAFC"))
                }
            }
            .alert("Logout", isPresented: $showLogoutConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) { }
            } message: {
                Text("Are you sure you want to log out of your account?")
            }
        }
    }
    
    private var headerBar: some View {
        HStack {
            Spacer()
            Text("Profile")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.white)
            Spacer()
        }
        .frame(height: 48)
        .background(Color(hex: "2563EB"))
    }
    
    private var settingsSection: some View {
        ProfileMenuGroupView(title: "Settings") {
            ProfileMenuRowView(
                iconName: "sparkles",
                title: "Manage Token",
                trailingType: .navigation
            ) {
            }
            
            Divider()
                .foregroundStyle(Color.baseStroke)
                .padding(.leading, 54)
            
            ProfileMenuRowView(
                iconName: "envelope",
                title: "Email Center",
                trailingType: .navigation
            ) {
            }
            
            Divider()
                .foregroundStyle(Color.baseStroke)
                .padding(.leading, 54)
            
            ProfileMenuRowView(
                iconName: "bell",
                title: "Notification",
                trailingType: .toggle($isNotificationEnabled)
            )
        }
    }
    
    private var securitySection: some View {
        ProfileMenuGroupView(title: "Security") {
            ProfileMenuRowView(
                iconName: "key",
                title: "Change Password",
                trailingType: .navigation
            ) {
            }
            
            Divider()
                .foregroundStyle(Color.baseStroke)
                .padding(.leading, 54)
            
            ProfileMenuRowView(
                iconName: "envelope",
                title: "Terms and Conditions",
                trailingType: .navigation
            ) {
            }
        }
    }
}

#Preview {
    ProfileView()
}
