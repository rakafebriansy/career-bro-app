//
//  ProfileHeaderCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct ProfileHeaderCardView: View {
    let name: String
    let email: String
    var onEditTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 14) {
            avatarView
            
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.black)
                
                Text(email)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color(hex: "737373"))
            }
            
            Spacer()
            
            Button {
                onEditTapped?()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "pencil")
                        .font(.system(size: 13, weight: .medium))
                    Text("Edit")
                        .font(.system(size: 14, weight: .medium))
                }
                .foregroundStyle(Color.blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.blue, lineWidth: 1.2)
                )
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.04), radius: 8, y: 2)
    }
    
    private var avatarView: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "E0E7FF"))
                .frame(width: 54, height: 54)
            
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 54, height: 54)
                .foregroundStyle(Color(hex: "4B5563"))
                .clipShape(Circle())
        }
    }
}
