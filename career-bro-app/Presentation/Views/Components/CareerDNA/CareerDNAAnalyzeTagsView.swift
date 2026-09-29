//
//  CareerDNAAnalyzeTagsView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerDNAAnalyzeTagsView: View {
    private let tags: [(title: String, bgColor: String, textColor: String)] = [
        ("Experiences", "#F3E8FF", "#9333EA"),
        ("Interests", "#E0F2FE", "#0284C7"),
        ("Strengths", "#FFE4E6", "#E11D48"),
        ("Work Style", "#FEF3C7", "#D97706")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What We Analyze")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.baseText)

            ViewThatFits(in: .horizontal) {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.title) { tag in
                        Badge(
                            tag.title,
                            color: Color(hex: tag.bgColor),
                            textColor: Color(hex: tag.textColor)
                        )
                    }
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(tags, id: \.title) { tag in
                            Badge(
                                tag.title,
                                color: Color(hex: tag.bgColor),
                                textColor: Color(hex: tag.textColor)
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CareerDNAAnalyzeTagsView()
        .padding()
}
