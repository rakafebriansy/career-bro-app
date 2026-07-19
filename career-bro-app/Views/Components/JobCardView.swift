//
//  JobCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import SwiftUI

struct JobCardView: View {
    let job: JobApplicationModel
    let showHeader: Bool = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                Text(job.status.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.baseWhite)
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                .fill(job.status.color)
            )
            
            VStack {
                HStack (alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(job.position)
                            .fontWeight(.semibold)
                            .foregroundStyle(.textPrimary)
                        Text(job.company)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(.baseText)
                        if let info = job.deadlineInfo {
                                Label {
                                    Text(info.formattedDate)
                                } icon: {
                                    Image(systemName: "calendar")
                                }
                                .font(.caption2)
                                .foregroundStyle(.baseText)
                            } else {
                                Text("No upcoming schedule")
                                    .italic()
                                    .font(.caption2)
                                    .foregroundStyle(.baseText)
                            }
                    }
                    Spacer()
                    VStack (alignment: .trailing) {
                        Badge(job.priority.rawValue, color: job.priority.backgroundColor, textColor: job.priority.foregroundColor)
                        Spacer()
                        if let info = job.deadlineInfo {
                            VStack (alignment: .trailing) {
                                Text(info.relativeStatus)
                                    .font(.caption2)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.baseText)
                                Text("to \(info.stageLabel)")
                                    .font(.system(size: 9, weight: .light))
                                    .foregroundStyle(.baseText)
                            }
                        }
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                UnevenRoundedRectangle(bottomLeadingRadius: 12, bottomTrailingRadius: 12)
                    .fill(Color(.systemBackground))
            )
            .overlay(
                UnevenRoundedRectangle(topLeadingRadius: 0,
                                       bottomLeadingRadius: 12,
                                       bottomTrailingRadius: 12,
                                       topTrailingRadius: 0)
                .stroke(.baseStroke, lineWidth: 2)
                    .padding(.top, -2)
            )
            .clipped()
        }
        .background(Color.blue)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }
}

#Preview {
    JobCardView(job: JobApplicationModel.dummyData[0])
}
