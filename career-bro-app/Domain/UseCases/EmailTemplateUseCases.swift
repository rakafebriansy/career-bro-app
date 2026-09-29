//
//  EmailTemplateUseCases.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct GetEmailTemplatesUseCase {
    private let repository: EmailTemplateRepositoryProtocol

    init(repository: EmailTemplateRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [EmailTemplateEntity] {
        try await repository.getTemplates()
    }
}

struct SaveEmailTemplateUseCase {
    private let repository: EmailTemplateRepositoryProtocol

    init(repository: EmailTemplateRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ template: EmailTemplateEntity) async throws {
        try await repository.saveTemplate(template)
    }
}

struct UpdateEmailTemplateUseCase {
    private let repository: EmailTemplateRepositoryProtocol

    init(repository: EmailTemplateRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ template: EmailTemplateEntity) async throws {
        try await repository.updateTemplate(template)
    }
}

struct DeleteEmailTemplateUseCase {
    private let repository: EmailTemplateRepositoryProtocol

    init(repository: EmailTemplateRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ id: UUID) async throws {
        try await repository.deleteTemplate(id)
    }
}

struct ToggleFavoriteEmailTemplateUseCase {
    private let repository: EmailTemplateRepositoryProtocol

    init(repository: EmailTemplateRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ id: UUID) async throws {
        try await repository.toggleFavorite(id)
    }
}
