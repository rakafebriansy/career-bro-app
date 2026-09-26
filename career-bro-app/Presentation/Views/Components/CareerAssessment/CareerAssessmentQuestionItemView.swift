import SwiftUI

struct CareerAssessmentQuestionItemView: View {
    var questionNumber: Int = 1
    let question: String
    @Binding var selectedScore: Int?
    
    private let circleSizes: [CGFloat] = [38, 30, 24, 18, 24, 30, 38]
    
    private var isAnswered: Bool {
        selectedScore != nil
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .center) {
                Text(String(format: "%02d", questionNumber))
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(isAnswered ? Color.bgPrimary : Color.baseText)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(isAnswered ? Color(hex: "#EEECFE") : Color(hex: "#F1F5F9"))
                    .clipShape(Capsule())
                
                Spacer()
                
                if isAnswered {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.caption)
                            .foregroundStyle(Color.bgPrimary)
                        
                        Text("Answered")
                            .font(.caption2)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.bgPrimary)
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
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(
                    isAnswered ? Color.bgPrimary.opacity(0.35) : Color.baseStroke,
                    lineWidth: isAnswered ? 1.5 : 1
                )
        )
        .animation(.easeInOut(duration: 0.2), value: isAnswered)
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
                            .stroke(Color(hex: "#D1D5DB"), lineWidth: 1.5)
                    )
            }
        }
        .scaleEffect(isSelected ? 1.08 : 1.0)
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var score: Int? = 0
    
    var body: some View {
        CareerAssessmentQuestionItemView(
            questionNumber: 1,
            question: "Do you enjoy working in a collaborative team environment?",
            selectedScore: $score
        )
        .padding()
    }
}

