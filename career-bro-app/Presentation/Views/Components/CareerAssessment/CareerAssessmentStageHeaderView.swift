//
//  CareerAssessmentStageHeaderView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentStageHeaderView: View {
    let stageTitle: String
    let stageIndex: Int
    let answeredCount: Int
    let totalInStage: Int
    
    private var categoryDetails: (icon: String, description: String, bgColor: String, textColor: String) {
        switch stageTitle.lowercased() {
        case "work style":
            return (
                "briefcase.fill",
                "Explore your daily workflow, pacing, and collaboration style.",
                "#FEF3C7",
                "#D97706"
            )
        case "interests":
            return (
                "sparkles",
                "Discover the domains, creative pursuits, and topics that ignite your passion.",
                "#E0F2FE",
                "#0284C7"
            )
        case "strengths":
            return (
                "chart.line.uptrend.xyaxis",
                "Evaluate your core problem-solving, analytical, and leadership abilities.",
                "#FFE4E6",
                "#E11D48"
            )
        case "experiences":
            return (
                "person.fill.badge.shield.checkmark",
                "Reflect on your growth mindset, mentorship, and career aspirations.",
                "#F3E8FF",
                "#9333EA"
            )
        default:
            return (
                "sparkles.2",
                "Answer thoughtfully to discover your unique career profile.",
                "#EEECFE",
                "#4C40F7"
            )
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                HStack(spacing: 6) {
                    Image(systemName: categoryDetails.icon)
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Text(stageTitle)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color(hex: categoryDetails.textColor))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(hex: categoryDetails.bgColor))
                .clipShape(Capsule())
                
                Spacer()
                
                Text("\(answeredCount)/\(totalInStage) completed")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(answeredCount == totalInStage ? Color.bgPrimary : Color(hex: "#8E8E93"))
            }
            
            Text(categoryDetails.description)
                .font(.subheadline)
                .foregroundStyle(.baseText)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(2)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        CareerAssessmentStageHeaderView(
            stageTitle: "Work Style",
            stageIndex: 0,
            answeredCount: 4,
            totalInStage: 7
        )
        CareerAssessmentStageHeaderView(
            stageTitle: "Interests",
            stageIndex: 1,
            answeredCount: 7,
            totalInStage: 7
        )
    }
    .padding()
}
