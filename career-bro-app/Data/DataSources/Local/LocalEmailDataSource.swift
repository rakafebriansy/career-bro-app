//
//  LocalEmailDataSource.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

protocol LocalEmailDataSourceProtocol {
    func fetchTemplates() -> [EmailTemplateModel]
    func saveTemplate(_ template: EmailTemplateModel)
    func deleteTemplate(_ id: UUID)
}

final class LocalEmailDataSource: LocalEmailDataSourceProtocol {
    private let modelContext: ModelContext?
    private var inMemoryTemplates: [EmailTemplateModel] = EmailTemplateModel.sampleTemplates
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    func fetchTemplates() -> [EmailTemplateModel] {
        guard let context = modelContext else {
            return inMemoryTemplates
        }
        let descriptor = FetchDescriptor<EmailTemplateModel>()
        if let fetched = try? context.fetch(descriptor), !fetched.isEmpty {
            return fetched
        }
        return inMemoryTemplates
    }
    
    func saveTemplate(_ template: EmailTemplateModel) {
        if let context = modelContext {
            let targetId = template.id
            let descriptor = FetchDescriptor<EmailTemplateModel>(predicate: #Predicate { $0.id == targetId })
            if let existing = try? context.fetch(descriptor).first {
                existing.title = template.title
                existing.tags = template.tags
                existing.subject = template.subject
                existing.body = template.body
                existing.attachments = template.attachments
            } else {
                context.insert(template)
            }
            try? context.save()
        } else {
            if let index = inMemoryTemplates.firstIndex(where: { $0.id == template.id }) {
                inMemoryTemplates[index] = template
            } else {
                inMemoryTemplates.insert(template, at: 0)
            }
        }
    }
    
    func deleteTemplate(_ id: UUID) {
        if let context = modelContext {
            let targetId = id
            let descriptor = FetchDescriptor<EmailTemplateModel>(predicate: #Predicate { $0.id == targetId })
            if let existing = try? context.fetch(descriptor).first {
                context.delete(existing)
                try? context.save()
            }
        } else {
            inMemoryTemplates.removeAll { $0.id == id }
        }
    }
}
