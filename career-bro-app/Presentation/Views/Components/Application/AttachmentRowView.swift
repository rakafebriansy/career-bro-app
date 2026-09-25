//
//  AttachmentRowView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 24/09/26.
//

import SwiftUI

struct AttachmentRowView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color.black.opacity(0.7))
                .lineLimit(1)
                .truncationMode(.middle)
            
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
    }
}

#Preview {
    VStack(spacing: 8) {
        AttachmentRowView(title: "glints/aksdjbasjb/jdddsa.com")
        AttachmentRowView(title: "flyer.jpg")
    }
    .padding()
}
