//
//  RoboChatAttachmentCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatAttachmentCardView: View {
    let attachment: ChatAttachmentModel
    var onRemove: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "doc")
                .font(.system(size: 22, weight: .regular))
                .foregroundStyle(Color(hex: "374151"))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(attachment.fileName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color(hex: "1F2937"))
                
                Text(attachment.fileSize)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: "9CA3AF"))
            }
            
            if let onRemove = onRemove {
                Spacer()
                Button {
                    onRemove()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(Color(hex: "9CA3AF"))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.02), radius: 4, y: 1)
    }
}

#Preview {
    RoboChatAttachmentCardView(
        attachment: ChatAttachmentModel(fileName: "Flyer.pdf", fileSize: "200 KB")
    )
    .padding()
}
