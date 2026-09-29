//
//  EmailCenterViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class EmailCenterViewModel {
    var templates: [EmailTemplateEntity] = []
    var selectedCategory: String = "All"
    var searchQuery: String = ""
    var isCreatePresented: Bool = false
    var selectedTemplateForEdit: EmailTemplateEntity? = nil
    var selectedTemplateForCompose: EmailTemplateEntity? = nil
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let getEmailTemplatesUseCase: GetEmailTemplatesUseCase
    private let deleteEmailTemplateUseCase: DeleteEmailTemplateUseCase
    private let toggleFavoriteEmailTemplateUseCase: ToggleFavoriteEmailTemplateUseCase

    init(
        getEmailTemplatesUseCase: GetEmailTemplatesUseCase = GetEmailTemplatesUseCase(repository: EmailTemplateRepository()),
        deleteEmailTemplateUseCase: DeleteEmailTemplateUseCase = DeleteEmailTemplateUseCase(repository: EmailTemplateRepository()),
        toggleFavoriteEmailTemplateUseCase: ToggleFavoriteEmailTemplateUseCase = ToggleFavoriteEmailTemplateUseCase(repository: EmailTemplateRepository())
    ) {
        self.getEmailTemplatesUseCase = getEmailTemplatesUseCase
        self.deleteEmailTemplateUseCase = deleteEmailTemplateUseCase
        self.toggleFavoriteEmailTemplateUseCase = toggleFavoriteEmailTemplateUseCase
    }

    @MainActor
    func fetchTemplates() async {
        isLoading = true
        errorMessage = nil
        do {
            templates = try await getEmailTemplatesUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    var filteredTemplates: [EmailTemplateEntity] {
        var result = templates
        if selectedCategory != "All" {
            result = result.filter { $0.tags.contains(selectedCategory) }
        }
        if !searchQuery.isEmpty {
            result = result.filter {
                $0.title.localizedCaseInsensitiveContains(searchQuery) ||
                $0.subject.localizedCaseInsensitiveContains(searchQuery) ||
                $0.body.localizedCaseInsensitiveContains(searchQuery)
            }
        }
        return result
    }

    @MainActor
    func deleteTemplate(id: UUID) async {
        do {
            try await deleteEmailTemplateUseCase.execute(id)
            templates.removeAll { $0.id == id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
