//
//  SummaryCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import SwiftUI

struct SummaryCardView: View {
    let data: SummaryData
    
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

#Preview {
    SummaryCardView(data: SummaryData.dummyData[0])
}
