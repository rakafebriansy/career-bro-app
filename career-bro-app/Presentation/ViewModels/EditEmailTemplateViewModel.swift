//
//  EditEmailTemplateViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class EditEmailTemplateViewModel {
    var id: UUID
    var title: String
    var tags: [String]
    var subject: String
    var body: String
    var isSuccess: Bool = false
    var errorMessage: String? = nil
    
    private let updateEmailTemplateUseCase: UpdateEmailTemplateUseCase
    
    init(
        template: EmailTemplateEntity,
        updateEmailTemplateUseCase: UpdateEmailTemplateUseCase = UpdateEmailTemplateUseCase(repository: EmailTemplateRepository())
    ) {
        self.id = template.id
        self.title = template.title
        self.tags = template.tags
        self.subject = template.subject
        self.body = template.body
        self.updateEmailTemplateUseCase = updateEmailTemplateUseCase
    }
    
    @MainActor
    func saveChanges() async {
        let updated = EmailTemplateEntity(
            id: id,
            title: title,
            tags: tags,
            subject: subject,
            body: body
        )
        do {
            try await updateEmailTemplateUseCase.execute(updated)
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func insertPlaceholder(_ placeholder: String, isSubjectField: Bool) {
        if isSubjectField {
            subject += (subject.isEmpty ? "" : " ") + placeholder
        } else {
            body += (body.isEmpty ? "" : " ") + placeholder
        }
    }
}
