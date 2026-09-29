//
//  ProfileLogoutButtonView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct ProfileLogoutButtonView: View {
    var onLogoutTapped: (() -> Void)? = nil

    var body: some View {
        Button {
            onLogoutTapped?()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color(hex: "DC2626"))

                Text("Logout")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color(hex: "DC2626"))

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}
