//
//  RoboChatInputBarView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatInputBarView: View {
    @Binding var text: String
    var attachedDocument: ChatAttachmentModel? = nil
    var onRemoveAttachment: (() -> Void)? = nil
    var onSend: () -> Void
    var onAttachmentTap: (() -> Void)? = nil
    var onProfileContextTap: (() -> Void)? = nil
    
    private var isSendEnabled: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || attachedDocument != nil
    }
    
    var body: some View {
        VStack(spacing: 8) {
            if let document = attachedDocument {
                HStack {
                    RoboChatAttachmentCardView(attachment: document) {
                        onRemoveAttachment?()
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            
            HStack(spacing: 8) {
                Button {
                    onAttachmentTap?()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.bgPrimary)
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
                
                Button {
                    onProfileContextTap?()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Color.bgPrimary)
                            .frame(width: 28, height: 28)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
                
                TextField("Ask Robo..", text: $text)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color.black)
                    .onSubmit {
                        if isSendEnabled {
                            onSend()
                        }
                    }
                
                Button {
                    if isSendEnabled {
                        onSend()
                    }
                } label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(isSendEnabled ? Color.bgPrimary : Color(hex: "94A3B8"))
                        .rotationEffect(.degrees(45))
                        .padding(.horizontal, 4)
                }
                .buttonStyle(.plain)
                .disabled(!isSendEnabled)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color.white)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.10), radius: 14, x: 0, y: 5)
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 1)
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 6)
    }
}

#Preview {
    RoboChatInputBarView(
        text: .constant("Could you help to review my CV?"),
        attachedDocument: ChatAttachmentModel(fileName: "Flyer.pdf", fileSize: "200 KB"),
        onSend: { }
    )
}
