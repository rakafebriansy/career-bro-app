//
//  CareerAssessmentResultRoadmapView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentResultRoadmapView: View {
    struct RoadmapStep: Identifiable {
        let id = UUID()
        let level: String
        let title: String
        let isCurrent: Bool
        let salaryRange: String
        let requiredSkills: String
    }

    var steps: [RoadmapStep] = [
        RoadmapStep(
            level: "Junior",
            title: "Junior UI/UX",
            isCurrent: true,
            salaryRange: "7-8M/month",
            requiredSkills: "Figma, Prototype, Wireframe, Hi-Fi, User Research"
        ),
        RoadmapStep(
            level: "Middle",
            title: "Product Designer",
            isCurrent: false,
            salaryRange: "10-15M/month",
            requiredSkills: "Design Systems, User Testing, Strategy, Analytics"
        ),
        RoadmapStep(
            level: "Senior",
            title: "Lead of Design",
            isCurrent: false,
            salaryRange: "18-25M/month",
            requiredSkills: "Team Leadership, Design Vision, Stakeholder Management"
        )
    ]

    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Roadmap")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            stepperView

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                        roadmapCard(step: step)
                            .frame(width: 290)
                    }
                }
                .padding(.horizontal, 2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var stepperView: some View {
        HStack(alignment: .top, spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 0) {
                        stepIndicator(for: index, isCurrent: step.isCurrent)

                        if index < steps.count - 1 {
                            Rectangle()
                                .fill(Color.baseStroke)
                                .frame(height: 2)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 4)
                        }
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(step.level)
                            .font(.caption2)
                            .foregroundStyle(Color(hex: "#737373"))

                        Text(step.title)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: index == steps.count - 1 ? 90 : .infinity)
            }
        }
    }

    private func stepIndicator(for index: Int, isCurrent: Bool) -> some View {
        ZStack {
            if isCurrent {
                Circle()
                    .stroke(Color.bgPrimary.opacity(0.3), lineWidth: 3)
                    .frame(width: 28, height: 28)

                Circle()
                    .fill(Color.bgPrimary)
                    .frame(width: 20, height: 20)

                Image(systemName: "lock.fill")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white)
            } else {
                Circle()
                    .stroke(Color.baseStroke, lineWidth: 1.5)
                    .frame(width: 24, height: 24)

                Image(systemName: "circle.grid.3x3.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(Color(hex: "#737373"))
            }
        }
        .frame(width: 28, height: 28)
    }

    private func roadmapCard(step: RoadmapStep) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "briefcase.fill")
                    .foregroundStyle(Color.bgPrimary)
                    .font(.subheadline)

                Text(step.title)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(.textPrimary)
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "banknote")
                        .font(.caption)
                        .foregroundStyle(Color(hex: "#737373"))
                        .frame(width: 16)

                    Text("Earn : \(step.salaryRange)")
                        .font(.caption)
                        .foregroundStyle(Color(hex: "#737373"))
                }

                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "laptopcomputer")
                        .font(.caption)
                        .foregroundStyle(Color(hex: "#737373"))
                        .frame(width: 16)

                    Text("Required Skill : \(step.requiredSkills)")
                        .font(.caption)
                        .foregroundStyle(Color(hex: "#737373"))
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
    }
}

#Preview {
    CareerAssessmentResultRoadmapView()
        .padding()
}
