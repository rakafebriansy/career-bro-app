//
//  GlobalSearchViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import SwiftData
import Observation

@Observable
final class GlobalSearchViewModel {
    private let recentSearchesKey = "career_bro_recent_searches"

    var searchText: String = ""
    var selectedCategory: SearchResultCategoryEnum = .all
    var searchResults: [UniversalSearchResultEntity] = []
    var recentSearches: [String] = []
    var quickPicks: [UniversalSearchResultEntity] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let universalSearchUseCase = UniversalSearchUseCase()
    private var currentModelContext: ModelContext? = nil

    init() {
        self.recentSearches = UserDefaults.standard.stringArray(forKey: recentSearchesKey) ?? []
        self.quickPicks = universalSearchUseCase.getQuickPicks()
    }

    func setModelContext(_ context: ModelContext) {
        self.currentModelContext = context
        self.quickPicks = universalSearchUseCase.getQuickPicks(modelContext: context)
        Task { @MainActor in
            await performSearch()
        }
    }

    @MainActor
    func performSearch() async {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmed.isEmpty && selectedCategory == .all {
            searchResults = []
            isLoading = false
            return
        }

        isLoading = true
        errorMessage = nil
        do {
            searchResults = try await universalSearchUseCase.execute(
                query: trimmed,
                category: selectedCategory,
                modelContext: currentModelContext
            )
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func selectCategory(_ category: SearchResultCategoryEnum) {
        selectedCategory = category
        Task { @MainActor in
            await performSearch()
        }
    }

    func addRecentSearch(_ term: String) {
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        var updated = recentSearches
        if let idx = updated.firstIndex(of: trimmed) {
            updated.remove(at: idx)
        }
        updated.insert(trimmed, at: 0)
        if updated.count > 10 {
            updated.removeLast()
        }
        recentSearches = updated
        UserDefaults.standard.set(updated, forKey: recentSearchesKey)
    }

    func removeRecentSearch(_ term: String) {
        var updated = recentSearches
        updated.removeAll(where: { $0 == term })
        recentSearches = updated
        UserDefaults.standard.set(updated, forKey: recentSearchesKey)
    }

    func clearRecentSearches() {
        recentSearches = []
        UserDefaults.standard.removeObject(forKey: recentSearchesKey)
    }

    func handleSelectResult(_ item: UniversalSearchResultEntity) {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            addRecentSearch(trimmed)
        }
    }
}
