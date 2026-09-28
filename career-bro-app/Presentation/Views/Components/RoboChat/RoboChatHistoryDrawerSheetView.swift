//
//  RoboChatHistoryDrawerSheetView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatHistoryDrawerSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    var sessions: [ChatSessionModel] = ChatSessionModel.sampleSessions
    var onSelectSession: ((ChatSessionModel) -> Void)? = nil
    var onNewChat: (() -> Void)? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                newChatButton
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Conversations")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color(hex: "64748B"))
                            .textCase(.uppercase)
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        
                        VStack(spacing: 10) {
                            ForEach(sessions) { session in
                                sessionRow(session)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.bottom, 24)
                }
            }
            .background(Color(hex: "F8FAFC"))
            .navigationTitle("Chat History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.bgPrimary)
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
    
    private var newChatButton: some View {
        Button {
            onNewChat?()
            dismiss()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus.bubble.fill")
                    .font(.system(size: 15))
                Text("Start New Chat")
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(Color.bgPrimary)
            .clipShape(Capsule())
            .shadow(color: Color.bgPrimary.opacity(0.2), radius: 6, y: 3)
        }
        .buttonStyle(.plain)
    }
    
    private func sessionRow(_ session: ChatSessionModel) -> some View {
        Button {
            onSelectSession?(session)
            dismiss()
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(session.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color(hex: "1F2937"))
                    
                    Spacer()
                    
                    Text(session.date, format: .dateTime.month(.abbreviated).day())
                        .font(.system(size: 11.5))
                        .foregroundStyle(Color(hex: "9CA3AF"))
                }
                
                Text(session.preview)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color(hex: "64748B"))
                    .lineLimit(2)
            }
            .padding(14)
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

#Preview {
    RoboChatHistoryDrawerSheetView()
}
