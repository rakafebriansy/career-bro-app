//
//  JobCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import SwiftData

struct JobCardView: View {
    let job: JobApplicationModel
    var showHeader: Bool = false
    var showCheckbox: Bool = false
    var isChecked: Bool = false
    var onToggleCheck: (() -> Void)? = nil
    
    var body: some View {
        if showHeader {
            headerCardView
        } else {
            compactCardView
        }
    }
    
    private var compactCardView: some View {
        HStack(alignment: .top, spacing: 12) {
            if showCheckbox {
                Button(action: {
                    onToggleCheck?()
                }) {
                    ZStack {
                        if isChecked {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.blue)
                                .frame(width: 20, height: 20)
                            Image(systemName: "checkmark")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(.white)
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.baseStroke, lineWidth: 1.5)
                                .frame(width: 20, height: 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(.systemBackground))
                                )
                        }
                    }
                }
                .buttonStyle(.plain)
                .padding(.top, 2)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center) {
                    Text(job.position)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                    Spacer()
                    if job.status != .offered && job.status != .accepted && job.status != .rejected {
                        Badge(job.priority.rawValue, color: job.priority.backgroundColor, textColor: job.priority.foregroundColor)
                    }
                }
                
                Text(job.company)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.baseText)
                
                if let info = job.deadlineInfo {
                    HStack(alignment: .center) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                            Text(job.status == .needToApply ? (info.formattedDate.components(separatedBy: " | ").first ?? info.formattedDate) : info.formattedDate)
                        }
                        .font(.footnote)
                        .foregroundStyle(.baseText)
                        
                        Spacer()
                        
                        Text(info.relativeStatus)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(hex: "F27F1B"))
                    }
                    .padding(.top, 2)
                } else if job.status == .applied {
                    Text("Moved 2h ago")
                        .font(.footnote)
                        .foregroundStyle(.baseText)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.baseStroke, lineWidth: 1.5)
        )
    }
    
    private var headerCardView: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(job.status.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.baseWhite)
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(
                UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                    .fill(job.status.color)
            )
            
            VStack {
                HStack(alignment: .top) {
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
                    VStack(alignment: .trailing) {
                        Badge(job.priority.rawValue, color: job.priority.backgroundColor, textColor: job.priority.foregroundColor)
                        Spacer()
                        if let info = job.deadlineInfo {
                            VStack(alignment: .trailing) {
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
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 12,
                    bottomTrailingRadius: 12,
                    topTrailingRadius: 0
                )
                .stroke(.baseStroke, lineWidth: 2)
                .padding(.top, -2)
            )
            .clipped()
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    let sample = SwiftDataSeeder.fetchFirstSample(context: SwiftDataSeeder.previewContainer.mainContext)
    return VStack(spacing: 20) {
        JobCardView(job: sample, showHeader: false)
        JobCardView(job: sample, showHeader: true)
    }
    .padding()
    .modelContainer(SwiftDataSeeder.previewContainer)
}
