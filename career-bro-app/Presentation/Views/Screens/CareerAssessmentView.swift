import SwiftUI

struct CareerAssessmentView: View {
    @Environment(\.dismiss) private var dismiss
    
    var questions: [CareerAssessmentQuestionModel] = CareerAssessmentLoader.loadQuestions()
    
    @State private var currentStageIndex: Int = 0
    @State private var answers: [Int: Int] = [:]
    @State private var showValidationErrors: Bool = false
    @State private var navigateToResult: Bool = false
    
    private struct AssessmentStage: Identifiable {
        let id: String
        let category: String
        let questions: [CareerAssessmentQuestionModel]
    }
    
    private var stages: [AssessmentStage] {
        let orderedCategories = ["Work Style", "Interests", "Strengths", "Experiences"]
        var grouped: [AssessmentStage] = []
        for cat in orderedCategories {
            let matching = questions.filter {
                ($0.category ?? "").caseInsensitiveCompare(cat) == .orderedSame
            }
            if !matching.isEmpty {
                grouped.append(AssessmentStage(id: cat, category: cat, questions: matching))
            }
        }
        let remaining = questions.filter { item in
            !orderedCategories.contains { cat in
                cat.caseInsensitiveCompare(item.category ?? "") == .orderedSame
            }
        }
        if !remaining.isEmpty {
            grouped.append(AssessmentStage(id: "General", category: "General", questions: remaining))
        }
        return grouped.isEmpty ? [AssessmentStage(id: "General", category: "General", questions: questions)] : grouped
    }
    
    private var currentStage: AssessmentStage? {
        guard !stages.isEmpty else { return nil }
        let index = min(max(currentStageIndex, 0), stages.count - 1)
        return stages[index]
    }
    
    private var answeredCount: Int {
        answers.count
    }
    
    private var stageAnsweredCount: Int {
        guard let stage = currentStage else { return 0 }
        return stage.questions.filter { answers[$0.id] != nil }.count
    }
    
    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 12)
            
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Color.clear
                            .frame(height: 1)
                            .id("stage_top")
                        
                        CareerAssessmentStageIndicatorView(
                            currentStage: currentStageIndex,
                            totalStages: max(stages.count, 1),
                            totalAnswered: answeredCount,
                            totalQuestions: max(questions.count, 1)
                        )
                        .padding(.top, 4)
                        
                        if let stage = currentStage {
                            CareerAssessmentStageHeaderView(
                                stageTitle: stage.category,
                                stageIndex: currentStageIndex,
                                answeredCount: stageAnsweredCount,
                                totalInStage: stage.questions.count
                            )
                            
                            VStack(spacing: 16) {
                                let previousQuestionsCount = stages.prefix(currentStageIndex).reduce(0) { $0 + $1.questions.count }
                                
                                ForEach(Array(stage.questions.enumerated()), id: \.element.id) { qIndex, questionItem in
                                    let continuousNumber = previousQuestionsCount + qIndex + 1
                                    let binding = Binding<Int?>(
                                        get: { answers[questionItem.id] },
                                        set: { newValue in
                                            if let val = newValue {
                                                answers[questionItem.id] = val
                                            } else {
                                                answers.removeValue(forKey: questionItem.id)
                                            }
                                        }
                                    )
                                    
                                    CareerAssessmentQuestionItemView(
                                        questionNumber: continuousNumber,
                                        question: questionItem.question,
                                        showError: showValidationErrors && answers[questionItem.id] == nil,
                                        selectedScore: binding
                                    )
                                    .id("question_\(questionItem.id)")
                                }
                            }
                        }
                        
                        bottomActionsView(proxy: proxy)
                            .padding(.top, 8)
                            .padding(.bottom, 32)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var topNavigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.baseText)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            Text("Assessment")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.baseText)
            
            Spacer()
            
            Color.clear
                .frame(width: 40, height: 40)
        }
    }
    
    private func bottomActionsView(proxy: ScrollViewProxy) -> some View {
        let isLastStage = currentStageIndex >= stages.count - 1
        let nextTitle = isLastStage ? "See Results" : "Next Stage"
        let nextIcon = isLastStage ? "sparkles" : "arrow.right"
        
        return CareerAssessmentBottomActionBarView(
            showBackButton: currentStageIndex > 0,
            backTitle: "Previous",
            nextTitle: nextTitle,
            nextIcon: nextIcon,
            onBack: {
                showValidationErrors = false
                if currentStageIndex > 0 {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        currentStageIndex -= 1
                    }
                    withAnimation {
                        proxy.scrollTo("stage_top", anchor: .top)
                    }
                }
            },
            onNext: {
                guard let stage = currentStage else { return }
                let unanswered = stage.questions.filter { answers[$0.id] == nil }
                
                if let firstUnanswered = unanswered.first {
                    let generator = UINotificationFeedbackGenerator()
                    generator.prepare()
                    generator.notificationOccurred(.error)
                    
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showValidationErrors = true
                    }
                    withAnimation(.easeInOut(duration: 0.3)) {
                        proxy.scrollTo("question_\(firstUnanswered.id)", anchor: .center)
                    }
                } else {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.prepare()
                    generator.impactOccurred()
                    
                    showValidationErrors = false
                    if !isLastStage {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            currentStageIndex += 1
                        }
                        withAnimation {
                            proxy.scrollTo("stage_top", anchor: .top)
                        }
                    } else {
                        navigateToResult = true
                    }
                }
            }
        )
        .navigationDestination(isPresented: $navigateToResult) {
            CareerAssessmentResultView()
        }
    }
}

#Preview {
    CareerAssessmentView()
}


