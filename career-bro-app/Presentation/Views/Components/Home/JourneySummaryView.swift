//
//  JourneySummaryView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct JourneySummaryView: View {
    var data: [JourneySummaryModel]

    init(_ data: [JourneySummaryModel]) {
        self.data = data
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            JourneySummaryChartView(data: data)

            HStack(spacing: 6) {
                ForEach(data) { item in
                    JourneySummaryCardView(data: item)
                }
            }
        }
    }
}

struct JourneySummaryCardView: View {
    let data: JourneySummaryModel

    var body: some View {
        VStack(spacing: 4) {
            Text(String(data.value))
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(data.color)

            Text(data.title)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 2)
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }
}

struct JourneySummaryChartView: View {
    let data: [JourneySummaryModel]

    private var totalValue: Int {
        data.reduce(0) { $0 + $1.value }
    }

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let activeItems = data.filter { $0.value > 0 }
            let spacing: CGFloat = 3
            let totalSpacing = CGFloat(max(0, activeItems.count - 1)) * spacing
            let availableWidth = max(0, totalWidth - totalSpacing)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(.systemGray5))
                    .frame(height: 7)

                if totalValue > 0 {
                    HStack(spacing: spacing) {
                        ForEach(activeItems) { item in
                            let fraction = CGFloat(item.value) / CGFloat(totalValue)
                            let width = max(6, fraction * availableWidth)

                            item.color
                                .frame(width: width, height: 7)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
        .frame(height: 7)
    }
}

#Preview {
    JourneySummaryView(SwiftDataSeeder.computeJourneySummary(from: SwiftDataSeeder.makeSampleApplications()))
        .padding()
}
