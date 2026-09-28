//
//  EditProfileView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var name: String = "Raka Febrian"
    @State var email: String = "rakafebrian@mail.com"
    var onSave: ((String, String) -> Void)? = nil
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {
                    ProfileAvatarEditorView()
                        .padding(.top, 12)
                    
                    VStack(spacing: 20) {
                        ProfileEditFormFieldView(
                            title: "Name",
                            text: $name,
                            placeholder: "Enter full name",
                            textContentType: .name,
                            autocapitalization: .words
                        )
                        
                        ProfileEditFormFieldView(
                            title: "Email",
                            text: $email,
                            placeholder: "Enter email address",
                            keyboardType: .emailAddress,
                            textContentType: .emailAddress,
                            autocapitalization: .never
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 24)
            }
            .background(Color.white)
            
            Spacer()
            
            bottomActionBar
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .alert("Validation", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var topNavigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.baseText)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Text("Edit Profile")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            Spacer()
            
            Color.clear
                .frame(width: 40, height: 40)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }
    
    private var bottomActionBar: some View {
        HStack(spacing: 14) {
            Button {
                dismiss()
            } label: {
                Text("Back")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.bgPrimary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.bgPrimary, lineWidth: 1.5)
                    )
            }
            .buttonStyle(.plain)
            
            Button {
                saveChanges()
            } label: {
                Text("Save")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.bgPrimary)
                    .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 24)
        .background(Color.white)
    }
    
    private func saveChanges() {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            alertMessage = "Please enter your name."
            showAlert = true
            return
        }
        
        guard !trimmedEmail.isEmpty, trimmedEmail.contains("@") else {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }
        
        onSave?(trimmedName, trimmedEmail)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
    }
}
