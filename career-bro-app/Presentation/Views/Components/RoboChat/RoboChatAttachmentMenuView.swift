//
//  RoboChatAttachmentMenuView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatAttachmentMenuView: View {
    var onUpgradeToken: (() -> Void)? = nil
    var onSelectPhoto: (() -> Void)? = nil
    var onOpenCamera: (() -> Void)? = nil
    var onSelectFile: (() -> Void)? = nil
    var onClose: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            menuRow(
                iconName: "sparkles",
                iconColor: Color.bgPrimary,
                title: "Upgrade Your Token",
                titleColor: Color.bgPrimary,
                fontWeight: .semibold
            ) {
                onUpgradeToken?()
                onClose?()
            }

            menuRow(
                iconName: "photo",
                iconColor: Color(hex: "0F172A"),
                title: "Photo",
                titleColor: Color(hex: "0F172A"),
                fontWeight: .medium
            ) {
                onSelectPhoto?()
                onClose?()
            }

            menuRow(
                iconName: "camera",
                iconColor: Color(hex: "0F172A"),
                title: "Camera",
                titleColor: Color(hex: "0F172A"),
                fontWeight: .medium
            ) {
                onOpenCamera?()
                onClose?()
            }

            menuRow(
                iconName: "paperclip",
                iconColor: Color(hex: "0F172A"),
                title: "File",
                titleColor: Color(hex: "0F172A"),
                fontWeight: .medium
            ) {
                onSelectFile?()
                onClose?()
            }
        }
        .padding(16)
        .frame(width: 250)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.12), radius: 18, x: 0, y: 8)
    }

    private func menuRow(
        iconName: String,
        iconColor: Color,
        title: String,
        titleColor: Color,
        fontWeight: Font.Weight,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "F1F5F9"))
                        .frame(width: 44, height: 44)

                    Image(systemName: iconName)
                        .font(.system(size: 19, weight: .regular))
                        .foregroundStyle(iconColor)
                }

                Text(title)
                    .font(.system(size: 16, weight: fontWeight))
                    .foregroundStyle(titleColor)

                Spacer()
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.2).ignoresSafeArea()
        RoboChatAttachmentMenuView()
    }
}
