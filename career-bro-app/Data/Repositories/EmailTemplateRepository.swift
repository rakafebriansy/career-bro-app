//
//  EmailTemplateRepository.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol EmailTemplateRepositoryProtocol {
    func getTemplates() async throws -> [EmailTemplateEntity]
    func getTemplateById(_ id: UUID) async throws -> EmailTemplateEntity?
    func saveTemplate(_ template: EmailTemplateEntity) async throws
    func updateTemplate(_ template: EmailTemplateEntity) async throws
    func deleteTemplate(_ id: UUID) async throws
    func toggleFavorite(_ id: UUID) async throws
}

final class EmailTemplateRepository: EmailTemplateRepositoryProtocol {
    private let dataSource: LocalEmailDataSourceProtocol
    
    init(dataSource: LocalEmailDataSourceProtocol = LocalEmailDataSource()) {
        self.dataSource = dataSource
    }
    
    func getTemplates() async throws -> [EmailTemplateEntity] {
        let models = dataSource.fetchTemplates()
        return models.map { mapToEntity($0) }
    }
    
    func getTemplateById(_ id: UUID) async throws -> EmailTemplateEntity? {
        let models = dataSource.fetchTemplates()
        guard let model = models.first(where: { $0.id == id }) else { return nil }
        return mapToEntity(model)
    }
    
    func saveTemplate(_ template: EmailTemplateEntity) async throws {
        let model = mapToModel(template)
        dataSource.saveTemplate(model)
    }
    
    func updateTemplate(_ template: EmailTemplateEntity) async throws {
        let model = mapToModel(template)
        dataSource.saveTemplate(model)
    }
    
    func deleteTemplate(_ id: UUID) async throws {
        dataSource.deleteTemplate(id)
    }
    
    func toggleFavorite(_ id: UUID) async throws {
        // Toggle if needed
    }
    
    // MARK: - Mappers
    private func mapToEntity(_ model: EmailTemplateModel) -> EmailTemplateEntity {
        EmailTemplateEntity(
            id: model.id,
            title: model.title,
            tags: model.tags,
            subject: model.subject,
            body: model.body,
            attachments: model.attachments.map {
                EmailAttachmentEntity(id: $0.id, fileName: $0.fileName, fileSizeString: $0.fileSizeString)
            }
        )
    }
    
    private func mapToModel(_ entity: EmailTemplateEntity) -> EmailTemplateModel {
        EmailTemplateModel(
            id: entity.id,
            title: entity.title,
            tags: entity.tags,
            subject: entity.subject,
            body: entity.body,
            attachments: entity.attachments.map {
                EmailAttachmentItem(id: $0.id, fileName: $0.fileName, fileSizeString: $0.fileSizeString)
            }
        )
    }
}
