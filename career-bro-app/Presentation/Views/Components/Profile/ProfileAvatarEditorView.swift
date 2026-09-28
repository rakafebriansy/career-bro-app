//
//  ProfileAvatarEditorView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct ProfileAvatarEditorView: View {
    var imageName: String? = nil
    var onAvatarTap: (() -> Void)? = nil
    
    var body: some View {
        Button {
            onAvatarTap?()
        } label: {
            ZStack {
                Circle()
                    .fill(Color(hex: "E0E7FF"))
                    .frame(width: 110, height: 110)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 110)
                    .foregroundStyle(Color(hex: "4B5563"))
                    .clipShape(Circle())
            }
            .overlay(
                Circle()
                    .stroke(Color.baseStroke, lineWidth: 1.5)
            )
            .shadow(color: Color.black.opacity(0.06), radius: 10, y: 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileAvatarEditorView()
        .padding()
}
