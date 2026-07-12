//
//  SummaryChartView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import SwiftUI


struct SummaryChartView: View {
    let data: [SummaryData]
    
    private var totalValue: Int {
        data.reduce(0) {
            $0 + $1.value
        }
    }
    
    var body: some View {
        GeometryReader {
            geometry in
            HStack (spacing: 4) {
                ForEach(data) {
                    item in
                    let width = Double(item.value) / Double(totalValue) * geometry.size.width
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
    SummaryChartView(data: SummaryData.dummyData)
}
