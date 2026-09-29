//
//  SearchViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class SearchViewModel {
    var applications: [JobApplicationEntity] = []
    var searchText: String = ""
    var selectedCategory: String = "All"
    var recentSearches: [String] = ["iOS Developer", "SwiftUI", "Product Designer", "Remote"]
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let getJobApplicationsUseCase: GetJobApplicationsUseCase

    init(
        getJobApplicationsUseCase: GetJobApplicationsUseCase = GetJobApplicationsUseCase(repository: JobApplicationRepository())
    ) {
        self.getJobApplicationsUseCase = getJobApplicationsUseCase
    }

    @MainActor
    func loadApplications() async {
        isLoading = true
        errorMessage = nil
        do {
            applications = try await getJobApplicationsUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    var filteredApplications: [JobApplicationEntity] {
        var results = applications
        if selectedCategory != "All" {
            results = results.filter {
                $0.position.localizedCaseInsensitiveContains(selectedCategory) ||
                ($0.keywords ?? []).contains(where: { $0.localizedCaseInsensitiveContains(selectedCategory) })
            }
        }
        if !searchText.isEmpty {
            results = results.filter {
                $0.position.localizedCaseInsensitiveContains(searchText) ||
                $0.company.localizedCaseInsensitiveContains(searchText) ||
                ($0.location ?? "").localizedCaseInsensitiveContains(searchText) ||
                ($0.keywords ?? []).contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
            }
        }
        return results
    }

    func addRecentSearch(_ term: String) {
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        if !recentSearches.contains(trimmed) {
            recentSearches.insert(trimmed, at: 0)
        }
    }

    func removeRecentSearch(_ term: String) {
        recentSearches.removeAll { $0 == term }
    }
}
