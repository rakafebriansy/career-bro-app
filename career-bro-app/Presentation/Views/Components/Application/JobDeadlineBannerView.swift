//
//  JobDeadlineBannerView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct JobDeadlineBannerView: View {
    let title: String
    let dateText: String
    let daysLeftText: String

    init(
        title: String = "Need to Apply",
        dateText: String = "Oct 12, 2026",
        daysLeftText: String = "4 Days Left"
    ) {
        self.title = title
        self.dateText = dateText
        self.daysLeftText = daysLeftText
    }

    init(deadlineInfo: JobDeadlineInfo) {
        self.title = deadlineInfo.stageLabel
        self.dateText = deadlineInfo.formattedDate
        self.daysLeftText = deadlineInfo.relativeStatus
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "calendar")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(Color(hex: "F39831"))

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color(hex: "F39831"))

                Text(dateText)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color(hex: "F39831"))
            }

            Spacer()

            Text(daysLeftText)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color(hex: "F39831"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(hex: "FEF5E0"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    JobDeadlineBannerView()
        .padding()
}
