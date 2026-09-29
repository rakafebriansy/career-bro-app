//
//  JobOverviewCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct JobOverviewCardView: View {
    let company: String
    let position: String
    let priority: PriorityEnum
    let location: String
    let salaryText: String
    let addedTimeText: String

    init(
        company: String = "Astra",
        position: String = "System Analyst",
        priority: PriorityEnum = .high,
        location: String = "Gading Serpong, Jakarta",
        salaryText: String = "7-8M/month",
        addedTimeText: String = "Added 2h ago"
    ) {
        self.company = company
        self.position = position
        self.priority = priority
        self.location = location
        self.salaryText = salaryText
        self.addedTimeText = addedTimeText
    }

    init(job: JobApplicationModel) {
        self.company = job.company
        self.position = job.position
        self.priority = job.priority
        self.location = job.location ?? "Gading Serpong, Jakarta"

        if let min = job.salaryMin, let max = job.salaryMax {
            if min >= 1_000_000 {
                let minM = Int(min / 1_000_000)
                let maxM = Int(max / 1_000_000)
                self.salaryText = "\(minM)-\(maxM)M/month"
            } else {
                let minK = Int(min / 1_000)
                let maxK = Int(max / 1_000)
                self.salaryText = "\(minK)-\(maxK)K/month"
            }
        } else if let min = job.salaryMin {
            let minM = Int(min / 1_000_000)
            self.salaryText = "From \(minM)M/month"
        } else {
            self.salaryText = "Salary Negotiable"
        }

        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .day], from: job.createdAt, to: now)
        if let day = components.day, day > 0 {
            self.addedTimeText = "Added \(day)d ago"
        } else if let hour = components.hour, hour > 0 {
            self.addedTimeText = "Added \(hour)h ago"
        } else {
            self.addedTimeText = "Added recently"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(company)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.baseText)

                Spacer()

                Badge(
                    priority.rawValue,
                    color: priority.backgroundColor,
                    textColor: priority.foregroundColor
                )
            }

            Text(position)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(Color.blue)

            HStack(spacing: 6) {
                Image(systemName: "location")
                    .font(.subheadline)
                    .foregroundStyle(.baseText)
                Text(location)
                    .font(.subheadline)
                    .foregroundStyle(.baseText)
            }

            HStack(alignment: .center) {
                HStack(spacing: 6) {
                    Image(systemName: "dollarsign.circle")
                        .font(.subheadline)
                        .foregroundStyle(.baseText)
                    Text(salaryText)
                        .font(.subheadline)
                        .foregroundStyle(.baseText)
                }

                Spacer()

                Text(addedTimeText)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.baseStroke, lineWidth: 1.5)
        )
    }
}

#Preview {
    JobOverviewCardView()
        .padding()
}
