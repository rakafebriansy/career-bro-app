//
//  RoboChatUseCases.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct GetChatSessionsUseCase {
    private let repository: RoboChatRepositoryProtocol
    
    init(repository: RoboChatRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [ChatSessionEntity] {
        try await repository.getChatSessions()
    }
}

struct GetInterviewerPersonasUseCase {
    private let repository: RoboChatRepositoryProtocol
    
    init(repository: RoboChatRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [InterviewerPersonaEntity] {
        try await repository.getPersonas()
    }
}

struct SendChatMessageUseCase {
    private let repository: RoboChatRepositoryProtocol
    
    init(repository: RoboChatRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(prompt: String, attachment: ChatAttachmentEntity?) async throws -> String {
        try await repository.generateReply(for: prompt, attachment: attachment)
    }
}
