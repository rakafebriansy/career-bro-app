//
//  CareerAssessmentStageIndicatorView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentStageIndicatorView: View {
    let currentStage: Int
    let totalStages: Int
    let totalAnswered: Int
    let totalQuestions: Int
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Stage \(currentStage + 1) of \(max(totalStages, 1))")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.bgPrimary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(hex: "#EEECFE"))
                    .clipShape(Capsule())
                
                Spacer()
                
                Text("\(totalAnswered)/\(totalQuestions) Answered")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(Color(hex: "#8E8E93"))
            }
            
            HStack(spacing: 6) {
                ForEach(0..<totalStages, id: \.self) { index in
                    Capsule()
                        .fill(indicatorColor(for: index))
                        .frame(height: 6)
                        .animation(.easeInOut(duration: 0.25), value: currentStage)
                }
            }
        }
    }
    
    private func indicatorColor(for index: Int) -> Color {
        if index < currentStage {
            return Color.bgPrimary
        } else if index == currentStage {
            return Color.bgPrimary
        } else {
            return Color(hex: "#E2E8F0")
        }
    }
}

#Preview {
    CareerAssessmentStageIndicatorView(
        currentStage: 0,
        totalStages: 4,
        totalAnswered: 5,
        totalQuestions: 25
    )
    .padding()
}
