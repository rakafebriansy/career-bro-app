//
//  RoboChatMessageBubbleView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatMessageBubbleView: View {
    let message: ChatMessageModel

    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            if message.isUser {
                Spacer(minLength: 48)

                VStack(alignment: .trailing, spacing: 8) {
                    if let attachment = message.attachment {
                        RoboChatAttachmentCardView(attachment: attachment)
                            .frame(maxWidth: 240)
                    }

                    if !message.text.isEmpty {
                        Text(message.text)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .background(Color.bgPrimary)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                            )
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .top, spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(Color.bgPrimary)
                                .frame(width: 32, height: 32)

                            Image(systemName: "sparkles")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.white)
                        }

                        Text(message.text)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color(hex: "374151"))
                            .lineSpacing(4)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 14)
                            .background(Color(hex: "F3F4F6"))
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                            )
                    }
                }

                Spacer(minLength: 48)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            ForEach(ChatMessageModel.sampleMockupConversation) { msg in
                RoboChatMessageBubbleView(message: msg)
            }
        }
        .padding(.vertical)
    }
    .background(Color.white)
}
