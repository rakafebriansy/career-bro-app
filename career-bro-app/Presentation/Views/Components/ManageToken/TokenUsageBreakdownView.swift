//
//  TokenUsageBreakdownView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct TokenUsageBreakdownView: View {
    struct FeatureUsageItem: Identifiable {
        let id = UUID()
        let name: String
        let icon: String
        let iconBgColor: Color
        let iconColor: Color
        let tokensUsed: Int
        let maxTokens: Int
        let countDescription: String
    }

    var items: [FeatureUsageItem] = [
        FeatureUsageItem(
            name: "AI Career Chatbot",
            icon: "bubble.left.and.bubble.right.fill",
            iconBgColor: Color(hex: "#EFF6FF"),
            iconColor: .bgPrimary,
            tokensUsed: 450,
            maxTokens: 1000,
            countDescription: "24 conversation turns"
        ),
        FeatureUsageItem(
            name: "Resume / CV AI Review",
            icon: "doc.text.magnifyingglass",
            iconBgColor: Color(hex: "#F0FDF4"),
            iconColor: Color(hex: "#16A34A"),
            tokensUsed: 200,
            maxTokens: 1000,
            countDescription: "4 document scans"
        ),
        FeatureUsageItem(
            name: "Cover Letter Generator",
            icon: "envelope.badge.shield.half.filled",
            iconBgColor: Color(hex: "#FAF5FF"),
            iconColor: Color(hex: "#9333EA"),
            tokensUsed: 100,
            maxTokens: 1000,
            countDescription: "2 letters drafted"
        ),
        FeatureUsageItem(
            name: "Career DNA & Assessment",
            icon: "chart.pie.fill",
            iconBgColor: Color(hex: "#FFF7ED"),
            iconColor: Color(hex: "#EA580C"),
            tokensUsed: 0,
            maxTokens: 1000,
            countDescription: "Unlimited in current plan"
        )
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Usage by Feature")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            VStack(spacing: 12) {
                ForEach(items) { item in
                    usageRow(item: item)
                }
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
    }

    private func usageRow(item: FeatureUsageItem) -> some View {
        VStack(spacing: 10) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.iconBgColor)
                        .frame(width: 40, height: 40)

                    Image(systemName: item.icon)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(item.iconColor)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textPrimary)

                    Text(item.countDescription)
                        .font(.caption2)
                        .foregroundStyle(Color(hex: "#737373"))
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(item.tokensUsed)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(item.tokensUsed > 0 ? .textPrimary : Color(hex: "#16A34A"))

                    Text("tokens")
                        .font(.caption2)
                        .foregroundStyle(Color(hex: "#737373"))
                }
            }

            if item.tokensUsed > 0 {
                GeometryReader { geo in
                    let ratio = min(Double(item.tokensUsed) / Double(item.maxTokens), 1.0)
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color.baseStroke.opacity(0.6))
                            .frame(height: 4)

                        Capsule()
                            .fill(item.iconColor)
                            .frame(width: max(geo.size.width * CGFloat(ratio), 8), height: 4)
                    }
                }
                .frame(height: 4)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TokenUsageBreakdownView()
        .padding()
}
