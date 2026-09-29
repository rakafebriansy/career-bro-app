//
//  CareerDNASummaryStatsView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerDNASummaryStatsView: View {
    var questionsCount: Int = 25
    var minutesCount: Int = 5
    var stagesCount: Int = 4

    var body: some View {
        HStack(spacing: 0) {
            statColumn(value: "\(questionsCount)", label: "Questions")

            Divider()
                .frame(height: 36)
                .background(Color.baseStroke)

            statColumn(value: "\(minutesCount)", label: "Minutes")

            Divider()
                .frame(height: 36)
                .background(Color.baseStroke)

            statColumn(value: "\(stagesCount)", label: "Stages")
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
    }

    private func statColumn(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.bgPrimary)

            Text(label)
                .font(.caption)
                .foregroundStyle(Color(hex: "#8E8E93"))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CareerDNASummaryStatsView()
        .padding()
}
