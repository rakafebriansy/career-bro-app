//
//  RoboChatViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class RoboChatViewModel {
    var messages: [ChatMessageEntity] = []
    var sessions: [ChatSessionEntity] = []
    var personas: [InterviewerPersonaEntity] = []
    var selectedPersona: InterviewerPersonaEntity?
    var inputText: String = ""
    var pendingAttachment: ChatAttachmentEntity? = nil
    var isRoboTyping: Bool = false
    var isSidebarOpen: Bool = false
    var showAttachmentMenu: Bool = false
    var showInterviewerSheet: Bool = false
    var showTokenAlert: Bool = false
    var tokensUsed: Int = 5
    var totalTokens: Int = 25
    var errorMessage: String? = nil
    
    private let getChatSessionsUseCase: GetChatSessionsUseCase
    private let getInterviewerPersonasUseCase: GetInterviewerPersonasUseCase
    private let sendChatMessageUseCase: SendChatMessageUseCase
    private let consumeTokenUseCase: ConsumeTokenUseCase
    
    init(
        getChatSessionsUseCase: GetChatSessionsUseCase = GetChatSessionsUseCase(repository: RoboChatRepository()),
        getInterviewerPersonasUseCase: GetInterviewerPersonasUseCase = GetInterviewerPersonasUseCase(repository: RoboChatRepository()),
        sendChatMessageUseCase: SendChatMessageUseCase = SendChatMessageUseCase(repository: RoboChatRepository()),
        consumeTokenUseCase: ConsumeTokenUseCase = ConsumeTokenUseCase(repository: TokenRepository())
    ) {
        self.getChatSessionsUseCase = getChatSessionsUseCase
        self.getInterviewerPersonasUseCase = getInterviewerPersonasUseCase
        self.sendChatMessageUseCase = sendChatMessageUseCase
        self.consumeTokenUseCase = consumeTokenUseCase
        self.messages = [
            ChatMessageEntity(
                text: "Could you help to review my CV?",
                isUser: true,
                attachment: ChatAttachmentEntity(fileName: "Flyer.pdf", fileSize: "200 KB")
            ),
            ChatMessageEntity(
                text: "Your CV is excellent, but let’s make it more perfect\n\npart of introduction better be like this\n“Hi, Im Maya, Digital Marketer for 5+ years experience……”",
                isUser: false
            )
        ]
    }
    
    @MainActor
    func loadInitialData() async {
        do {
            sessions = try await getChatSessionsUseCase.execute()
            personas = try await getInterviewerPersonasUseCase.execute()
            if selectedPersona == nil {
                selectedPersona = personas.first
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func sendMessage(text: String, attachment: ChatAttachmentEntity? = nil) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty || attachment != nil else { return }
        
        let userMessage = ChatMessageEntity(
            text: trimmed,
            isUser: true,
            attachment: attachment
        )
        
        withAnimation(.spring(duration: 0.3)) {
            messages.append(userMessage)
            if tokensUsed < totalTokens {
                tokensUsed += 1
            }
        }
        
        isRoboTyping = true
        
        do {
            _ = try await consumeTokenUseCase.execute(count: 1)
            let replyText = try await sendChatMessageUseCase.execute(prompt: trimmed, attachment: attachment)
            
            try await Task.sleep(nanoseconds: 800_000_000)
            
            let roboMessage = ChatMessageEntity(text: replyText, isUser: false)
            withAnimation(.spring(duration: 0.3)) {
                isRoboTyping = false
                messages.append(roboMessage)
            }
        } catch {
            isRoboTyping = false
            errorMessage = error.localizedDescription
        }
    }
    
    func startNewChat() {
        withAnimation {
            messages.removeAll()
            pendingAttachment = nil
            isSidebarOpen = false
        }
    }
    
    func selectSession(_ session: ChatSessionEntity) {
        withAnimation {
            messages = [
                ChatMessageEntity(text: session.title, isUser: true),
                ChatMessageEntity(text: session.preview, isUser: false)
            ]
            isSidebarOpen = false
        }
    }
}
