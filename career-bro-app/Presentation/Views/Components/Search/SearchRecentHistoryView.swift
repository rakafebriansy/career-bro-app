//
//  SearchRecentHistoryView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct SearchRecentHistoryView: View {
    let recentSearches: [String]
    let quickPicks: [UniversalSearchResultEntity]
    let onSelectTerm: (String) -> Void
    let onRemoveTerm: (String) -> Void
    let onClearAll: () -> Void
    let onSelectQuickPick: (UniversalSearchResultEntity) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            if !recentSearches.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Pencarian Terakhir")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.primary)

                        Spacer()

                        Button("Hapus Semua", action: onClearAll)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.red)
                    }
                    .padding(.horizontal, 16)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recentSearches, id: \.self) { term in
                                HStack(spacing: 6) {
                                    Button {
                                        onSelectTerm(term)
                                    } label: {
                                        HStack(spacing: 4) {
                                            Image(systemName: "clock.arrow.circlepath")
                                                .font(.system(size: 11))
                                                .foregroundStyle(Color.secondary)
                                            Text(term)
                                                .font(.system(size: 13, weight: .medium))
                                                .foregroundStyle(Color.primary)
                                        }
                                    }
                                    .buttonStyle(.plain)

                                    Button {
                                        onRemoveTerm(term)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 12))
                                            .foregroundStyle(Color.secondary.opacity(0.6))
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 7)
                                .background(Color(.secondarySystemGroupedBackground))
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(Color.primary.opacity(0.06), lineWidth: 1)
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 6) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.orange)

                    Text("Menu Terpopuler")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color.primary)
                }
                .padding(.horizontal, 16)

                if quickPicks.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "flame")
                            .font(.system(size: 28))
                            .foregroundStyle(Color.secondary.opacity(0.5))

                        Text("Belum ada terpopuler")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .padding(.horizontal, 16)
                } else {
                    VStack(spacing: 10) {
                        ForEach(quickPicks.prefix(3)) { item in
                            Button {
                                onSelectQuickPick(item)
                            } label: {
                                SearchResultItemCardView(item: item)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}
