//
//  JourneyCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import SwiftUI

struct JourneySummaryView: View {
    var data: [JourneySummaryModel]
    
    init(_ data: [JourneySummaryModel]) {
        self.data = data
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            JourneySummaryChartView(data: data)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(data) { item in
                        JourneySummaryCardView(data: item)
                    }
                }
            }
            .padding(.top, 4)
        }
    }
}

struct JourneySummaryCardView: View {
    let data: JourneySummaryModel
    
    var body: some View {
        VStack (alignment: .center) {
            Text(String(data.value))
                .bold()
                .font(.title3)
                .foregroundStyle(data.color)
            Text(data.title)
                .foregroundStyle(.baseText)
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.baseStroke, lineWidth: 2)
        )
    }
}

struct JourneySummaryChartView: View {
    let data: [JourneySummaryModel]
    
    private var totalValue: Int {
        data.reduce(0) {
            $0 + $1.value
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack (spacing: 4) {
                ForEach(data) { item in
                    let safeTotal = totalValue > 0 ? Double(totalValue) : 1.0
                    let width = totalValue > 0 ? (Double(item.value) / safeTotal * geometry.size.width) : 0
                    item.color
                        .frame(width: max(0, width - 4))
                        .clipShape(.capsule)
                }
            }
        }
        .frame(height: 10)
    }
}

#Preview {
    JourneySummaryView(SwiftDataSeeder.computeJourneySummary(from: SwiftDataSeeder.makeSampleApplications()))
}
