//
//  RoboChatPromptSuggestionsView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatPromptSuggestionsView: View {
    var categories: [PromptCategoryModel] = PromptCategoryModel.defaultCategories
    var onSelectPrompt: ((String) -> Void)? = nil
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {
                ForEach(categories) { category in
                    categorySection(for: category)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .padding(.bottom, 24)
        }
    }
    
    private func categorySection(for category: PromptCategoryModel) -> some View {
        VStack(spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: category.iconName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(Color(hex: "64748B"))
                
                Text(category.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color(hex: "64748B"))
            }
            
            VStack(spacing: 10) {
                ForEach(category.prompts, id: \.self) { prompt in
                    Button {
                        onSelectPrompt?(prompt)
                    } label: {
                        Text(prompt)
                            .font(.system(size: 13.5, weight: .regular))
                            .foregroundStyle(Color(hex: "334155"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color(hex: "F1F5F9"))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    RoboChatPromptSuggestionsView()
}
