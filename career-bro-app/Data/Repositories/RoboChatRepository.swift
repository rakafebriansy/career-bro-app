//
//  RoboChatRepository.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol RoboChatRepositoryProtocol {
    func getChatSessions() async throws -> [ChatSessionEntity]
    func getPersonas() async throws -> [InterviewerPersonaEntity]
    func generateReply(for prompt: String, attachment: ChatAttachmentEntity?) async throws -> String
}

final class RoboChatRepository: RoboChatRepositoryProtocol {
    private let chatDataSource: LocalChatDataSourceProtocol
    private let aiService: AIServiceProtocol
    
    init(
        chatDataSource: LocalChatDataSourceProtocol = LocalChatDataSource(),
        aiService: AIServiceProtocol = AIService()
    ) {
        self.chatDataSource = chatDataSource
        self.aiService = aiService
    }
    
    func getChatSessions() async throws -> [ChatSessionEntity] {
        return chatDataSource.getChatSessions()
    }
    
    func getPersonas() async throws -> [InterviewerPersonaEntity] {
        return chatDataSource.getPersonas()
    }
    
    func generateReply(for prompt: String, attachment: ChatAttachmentEntity?) async throws -> String {
        return await aiService.generateChatResponse(for: prompt, hasAttachment: attachment != nil)
    }
}
