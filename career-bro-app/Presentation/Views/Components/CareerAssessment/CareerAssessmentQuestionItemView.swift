import SwiftUI

struct CareerAssessmentQuestionItemView: View {
    var questionNumber: Int = 1
    let question: String
    var showError: Bool = false
    @Binding var selectedScore: Int?
    
    private let circleSizes: [CGFloat] = [38, 30, 24, 18, 24, 30, 38]
    
    private var isAnswered: Bool {
        selectedScore != nil
    }
    
    private var isErrorState: Bool {
        showError && !isAnswered
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center) {
                Text(String(format: "%02d", questionNumber))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(numberBadgeTextColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(numberBadgeBgColor)
                    .clipShape(Capsule())
                
                Spacer()
                
                if isAnswered {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(Color(hex: "#16A34A"))
                        
                        Text("Answered")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(hex: "#16A34A"))
                    }
                    .transition(.opacity.combined(with: .scale))
                } else if isErrorState {
                    HStack(spacing: 4) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(Color(hex: "#EF4444"))
                        
                        Text("Required")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color(hex: "#EF4444"))
                    }
                    .transition(.opacity.combined(with: .scale))
                }
            }
            
            Text(question)
                .font(.body)
                .fontWeight(.medium)
                .foregroundStyle(.textPrimary)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(2)
            
            VStack(spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(Color(hex: "#F1F5F9"))
                        .frame(height: 2)
                        .padding(.horizontal, 19)
                    
                    HStack(alignment: .center) {
                        ForEach(0..<7, id: \.self) { index in
                            let size = circleSizes[index]
                            let isSelected = selectedScore == index
                            
                            Button {
                                withAnimation(.spring(response: 0.28, dampingFraction: 0.65)) {
                                    selectedScore = isSelected ? nil : index
                                }
                            } label: {
                                optionCircle(size: size, isSelected: isSelected)
                            }
                            .buttonStyle(.plain)
                            
                            if index < 6 {
                                Spacer()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 2)
                }
                
                HStack {
                    Text("Agree")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(Color(hex: "#8E8E93"))
                    
                    Spacer()
                    
                    Text("Disagree")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(Color(hex: "#8E8E93"))
                }
            }
            .padding(.top, 4)
        }
        .padding(16)
        .background(cardBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(cardStrokeColor, lineWidth: cardStrokeWidth)
        )
        .animation(.easeInOut(duration: 0.2), value: isAnswered)
        .animation(.easeInOut(duration: 0.2), value: isErrorState)
    }
    
    private var numberBadgeTextColor: Color {
        if isErrorState {
            return Color(hex: "#DC2626")
        } else if isAnswered {
            return Color.bgPrimary
        } else {
            return Color.baseText
        }
    }
    
    private var numberBadgeBgColor: Color {
        if isErrorState {
            return Color(hex: "#FEE2E2")
        } else if isAnswered {
            return Color(hex: "#EEECFE")
        } else {
            return Color(hex: "#F1F5F9")
        }
    }
    
    private var cardBackgroundColor: Color {
        if isErrorState {
            return Color(hex: "#FEF2F2")
        } else {
            return Color.white
        }
    }
    
    private var cardStrokeColor: Color {
        if isErrorState {
            return Color(hex: "#EF4444")
        } else if isAnswered {
            return Color.bgPrimary.opacity(0.35)
        } else {
            return Color.baseStroke
        }
    }
    
    private var cardStrokeWidth: CGFloat {
        if isErrorState || isAnswered {
            return 1.5
        } else {
            return 1
        }
    }
    
    @ViewBuilder
    private func optionCircle(size: CGFloat, isSelected: Bool) -> some View {
        ZStack {
            if isSelected {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [.bgPrimary, .bgDarkPrimary],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    )
                
                Circle()
                    .fill(Color.baseWhite)
                    .frame(width: max(size * 0.36, 6), height: max(size * 0.36, 6))
            } else {
                Circle()
                    .fill(Color.white)
                    .frame(width: size, height: size)
                    .overlay(
                        Circle()
                            .stroke(
                                isErrorState ? Color(hex: "#FCA5A5") : Color(hex: "#D1D5DB"),
                                lineWidth: 1.5
                            )
                    )
            }
        }
        .scaleEffect(isSelected ? 1.08 : 1.0)
    }
}

#Preview {
    VStack(spacing: 16) {
        PreviewWrapper(score: 2, showError: false)
        PreviewWrapper(score: nil, showError: true)
        PreviewWrapper(score: nil, showError: false)
    }
    .padding()
}

private struct PreviewWrapper: View {
    @State var score: Int?
    var showError: Bool = false
    
    var body: some View {
        CareerAssessmentQuestionItemView(
            questionNumber: 1,
            question: "Do you enjoy working in a collaborative team environment?",
            showError: showError,
            selectedScore: $score
        )
    }
}


