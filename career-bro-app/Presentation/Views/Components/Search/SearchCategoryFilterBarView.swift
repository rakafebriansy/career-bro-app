//
//  SearchCategoryFilterBarView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct SearchCategoryFilterBarView: View {
    let selectedCategory: SearchResultCategoryEnum
    let onSelect: (SearchResultCategoryEnum) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(SearchResultCategoryEnum.allCases) { cat in
                    let isSelected = selectedCategory == cat
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            onSelect(cat)
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: cat.iconName)
                                .font(.system(size: 12, weight: isSelected ? .bold : .medium))

                            Text(cat.rawValue)
                                .font(.system(size: 13, weight: isSelected ? .semibold : .medium))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(isSelected ? Color.blue : Color(.secondarySystemGroupedBackground))
                        .foregroundStyle(isSelected ? Color.white : Color.primary)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(isSelected ? Color.clear : Color.primary.opacity(0.08), lineWidth: 1)
                        )
                        .shadow(color: isSelected ? Color.blue.opacity(0.25) : Color.clear, radius: 4, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
    }
}
