//
//  CreateEmailTemplateViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class CreateEmailTemplateViewModel {
    var title: String = ""
    var tags: [String] = ["Fullstack"]
    var subject: String = ""
    var body: String = ""
    var isSuccess: Bool = false
    var errorMessage: String? = nil

    private let saveEmailTemplateUseCase: SaveEmailTemplateUseCase

    init(
        saveEmailTemplateUseCase: SaveEmailTemplateUseCase = SaveEmailTemplateUseCase(repository: EmailTemplateRepository())
    ) {
        self.saveEmailTemplateUseCase = saveEmailTemplateUseCase
    }

    @MainActor
    func saveTemplate() async {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter a template title."
            return
        }

        let newTemplate = EmailTemplateEntity(
            title: title,
            tags: tags,
            subject: subject,
            body: body
        )

        do {
            try await saveEmailTemplateUseCase.execute(newTemplate)
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
