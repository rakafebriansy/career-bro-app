//
//  SearchView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppNavigationRouter.self) private var router: AppNavigationRouter?
    @Query(sort: \JobApplicationModel.createdAt, order: .reverse) private var applications: [JobApplicationModel]

    @State private var viewModel = GlobalSearchViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchInputBar
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color(.systemBackground))

                SearchCategoryFilterBarView(selectedCategory: viewModel.selectedCategory) { category in
                    viewModel.selectCategory(category)
                }
                .padding(.vertical, 8)
                .background(Color(.systemGroupedBackground))

                Divider()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        if viewModel.selectedCategory == .all && viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            SearchRecentHistoryView(
                                recentSearches: viewModel.recentSearches,
                                quickPicks: viewModel.quickPicks,
                                onSelectTerm: { term in
                                    viewModel.searchText = term
                                    Task {
                                        await viewModel.performSearch()
                                    }
                                },
                                onRemoveTerm: { term in
                                    viewModel.removeRecentSearch(term)
                                },
                                onClearAll: {
                                    viewModel.clearRecentSearches()
                                },
                                onSelectQuickPick: { item in
                                    viewModel.handleSelectResult(item)
                                    router?.offAllNamed(to: item.destination)
                                }
                            )
                            .padding(.top, 12)
                        } else {
                            if viewModel.isLoading {
                                HStack {
                                    Spacer()
                                    ProgressView("Memuat data...")
                                        .padding(.vertical, 40)
                                    Spacer()
                                }
                            } else if viewModel.searchResults.isEmpty {
                                emptyStateView
                            } else {
                                searchResultsSection
                            }
                        }
                    }
                    .padding(.bottom, 24)
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationTitle("Pencarian")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.setModelContext(modelContext)
            }
        }
    }

    private var searchInputBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.secondary)

            TextField("Cari menu, lamaran, email, chat AI...", text: $viewModel.searchText)
                .font(.system(size: 15))
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .onChange(of: viewModel.searchText) { _, _ in
                    Task {
                        await viewModel.performSearch()
                    }
                }
                .onSubmit {
                    Task {
                        await viewModel.performSearch()
                    }
                }

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                    Task {
                        await viewModel.performSearch()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(Color.secondary.opacity(0.7))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.primary.opacity(0.06), lineWidth: 1)
        )
    }

    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                let title = viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
                    "Daftar \(viewModel.selectedCategory.rawValue)" : "Hasil Pencarian"
                Text("\(title) (\(viewModel.searchResults.count))")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.primary)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)

            VStack(spacing: 10) {
                ForEach(viewModel.searchResults) { item in
                    Button {
                        viewModel.handleSelectResult(item)
                        router?.offAllNamed(to: item.destination)
                    } label: {
                        SearchResultItemCardView(item: item)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray.fill")
                .font(.system(size: 46, weight: .light))
                .foregroundStyle(Color.secondary.opacity(0.5))
                .padding(.top, 40)

            VStack(spacing: 6) {
                Text("Tidak Ada Data")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.primary)

                Text(viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
                     "Tidak ada data di kategori \(viewModel.selectedCategory.rawValue)." :
                     "Tidak ada data yang cocok dengan kata kunci \"\(viewModel.searchText)\".")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
    }
}

#Preview {
    SearchView()
        .modelContainer(SwiftDataSeeder.previewContainer)
}
