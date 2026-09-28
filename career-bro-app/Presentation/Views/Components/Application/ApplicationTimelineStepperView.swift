//
//  ApplicationTimelineStepperView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct ApplicationTimelineStepperView: View {
    struct Step: Identifiable {
        let id = UUID()
        let status: JobStatusEnum
        let title: String
        let state: StepState
    }
    
    enum StepState {
        case completed
        case current
        case upcoming
        case rejected
        case ghosted
    }
    
    var status: JobStatusEnum = .interview
    
    var progressiveStages: [JobStatusEnum] {
        [
            .needToApply,
            .applied,
            .assessment,
            .interview,
            .postInterview,
            .offered,
            .accepted
        ]
    }
    
    var steps: [Step] {
        let currentIndex: Int
        switch status {
        case .needToApply:
            currentIndex = 0
        case .applied:
            currentIndex = 1
        case .assessment:
            currentIndex = 2
        case .interview:
            currentIndex = 3
        case .postInterview:
            currentIndex = 4
        case .offered:
            currentIndex = 5
        case .accepted:
            currentIndex = 6
        case .rejected:
            currentIndex = 2
        case .ghosted:
            currentIndex = 1
        }
        
        return progressiveStages.enumerated().map { index, stage in
            let state: StepState
            if status == .rejected && index == currentIndex {
                state = .rejected
            } else if status == .ghosted && index == currentIndex {
                state = .ghosted
            } else if index < currentIndex {
                state = .completed
            } else if index == currentIndex {
                state = .current
            } else {
                state = .upcoming
            }
            return Step(status: stage, title: stage.rawValue, state: state)
        }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                    VStack(spacing: 8) {
                        ZStack {
                            if index < steps.count - 1 {
                                GeometryReader { geometry in
                                    Path { path in
                                        let midY = geometry.size.height / 2
                                        path.move(to: CGPoint(x: geometry.size.width / 2, y: midY))
                                        path.addLine(to: CGPoint(x: geometry.size.width * 1.5, y: midY))
                                    }
                                    .stroke(
                                        step.state == .completed ? Color.blue : Color(hex: "E5E7EB"),
                                        lineWidth: 2
                                    )
                                }
                            }
                            
                            nodeView(for: step.state)
                        }
                        .frame(height: 22)
                        
                        Text(step.title)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(step.state == .upcoming ? Color.gray.opacity(0.8) : Color.black.opacity(0.85))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(width: 86)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder
    private func nodeView(for state: StepState) -> some View {
        switch state {
        case .completed:
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                )
        case .current:
            Circle()
                .stroke(Color.blue, lineWidth: 1.5)
                .background(Circle().fill(Color.white))
                .frame(width: 20, height: 20)
                .overlay(
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 6, height: 6)
                )
        case .upcoming:
            Circle()
                .stroke(Color(hex: "D1D5DB"), lineWidth: 1.5)
                .background(Circle().fill(Color.white))
                .frame(width: 20, height: 20)
        case .rejected:
            Circle()
                .fill(Color(hex: "D93838"))
                .frame(width: 20, height: 20)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                )
        case .ghosted:
            Circle()
                .fill(Color(hex: "737373"))
                .frame(width: 20, height: 20)
                .overlay(
                    Image(systemName: "minus")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                )
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ApplicationTimelineStepperView(status: .needToApply)
        ApplicationTimelineStepperView(status: .applied)
        ApplicationTimelineStepperView(status: .assessment)
        ApplicationTimelineStepperView(status: .interview)
        ApplicationTimelineStepperView(status: .postInterview)
        ApplicationTimelineStepperView(status: .offered)
        ApplicationTimelineStepperView(status: .accepted)
        ApplicationTimelineStepperView(status: .rejected)
        ApplicationTimelineStepperView(status: .ghosted)
    }
}
