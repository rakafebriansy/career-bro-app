//
//  EmailAttachmentCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct EmailAttachmentCardView: View {
    let attachment: EmailAttachmentItem
    var onDelete: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "doc")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.textPrimary)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(attachment.fileName)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.textPrimary)
                
                Text(attachment.fileSizeString)
                    .font(.caption2)
                    .foregroundStyle(Color(hex: "#9CA3AF"))
            }
            
            Spacer()
            
            Button {
                onDelete?()
            } label: {
                Image(systemName: "trash.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: "#EF4444"))
                    .frame(width: 32, height: 32)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
    }
}

#Preview {
    EmailAttachmentCardView(
        attachment: EmailAttachmentItem(fileName: "CV.pdf", fileSizeString: "200 KB")
    )
    .padding()
}
