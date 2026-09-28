import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var profileName: String = "Raka Febrian"
    @State private var profileEmail: String = "rakafebrian@mail.com"
    @State private var isNotificationEnabled: Bool = true
    @State private var showLogoutConfirmation: Bool = false
    @State private var showResetDataConfirmation: Bool = false
    @State private var navigateToManageToken: Bool = false
    @State private var navigateToEmailCenter: Bool = false
    @State private var navigateToEditProfile: Bool = false
    
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
                                name: profileName,
                                email: profileEmail,
                                onEditTapped: {
                                    navigateToEditProfile = true
                                }
                            )
                            
                            settingsSection
                            
                            dataSection
                            
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
            .alert("Reset Data", isPresented: $showResetDataConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Reset Data", role: .destructive) {
                    SwiftDataSeeder.resetAndReseed(context: modelContext)
                }
            } message: {
                Text("Are you sure you want to reset all data? This will clear all changes and restore the default sample applications.")
            }
            .navigationDestination(isPresented: $navigateToManageToken) {
                ManageTokenView()
            }
            .navigationDestination(isPresented: $navigateToEmailCenter) {
                EmailCenterView()
            }
            .navigationDestination(isPresented: $navigateToEditProfile) {
                EditProfileView(name: profileName, email: profileEmail) { updatedName, updatedEmail in
                    profileName = updatedName
                    profileEmail = updatedEmail
                }
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
                navigateToManageToken = true
            }
            
            Divider()
                .foregroundStyle(Color.baseStroke)
                .padding(.leading, 54)
            
            ProfileMenuRowView(
                iconName: "envelope",
                title: "Email Center",
                trailingType: .navigation
            ) {
                navigateToEmailCenter = true
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
    
    private var dataSection: some View {
        ProfileMenuGroupView(title: "Data Management") {
            ProfileMenuRowView(
                iconName: "arrow.counterclockwise.circle",
                title: "Reset SwiftData",
                trailingType: .navigation
            ) {
                showResetDataConfirmation = true
            }
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
        .modelContainer(SwiftDataSeeder.previewContainer)
}
