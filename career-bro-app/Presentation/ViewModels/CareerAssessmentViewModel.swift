//
//  CareerAssessmentViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class CareerAssessmentViewModel {
    var currentStageIndex: Int = 0
    var questions: [CareerAssessmentQuestionEntity] = []
    var selectedAnswers: [Int: Int] = [:]
    var showValidationErrors: Bool = false
    var isCompleted: Bool = false
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let getQuestionsUseCase: GetCareerAssessmentQuestionsUseCase
    private let saveResultUseCase: SaveCareerAssessmentResultUseCase

    init(
        getQuestionsUseCase: GetCareerAssessmentQuestionsUseCase = GetCareerAssessmentQuestionsUseCase(repository: CareerAssessmentRepository()),
        saveResultUseCase: SaveCareerAssessmentResultUseCase = SaveCareerAssessmentResultUseCase(repository: CareerAssessmentRepository())
    ) {
        self.getQuestionsUseCase = getQuestionsUseCase
        self.saveResultUseCase = saveResultUseCase
    }

    @MainActor
    func loadQuestions() async {
        isLoading = true
        errorMessage = nil
        do {
            questions = try await getQuestionsUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    var stageCategories: [String] {
        ["Work Style", "Interests", "Strengths", "Experiences"]
    }

    func questionsForCategory(_ category: String) -> [CareerAssessmentQuestionEntity] {
        questions.filter { ($0.category ?? "").caseInsensitiveCompare(category) == .orderedSame }
    }

    var overallProgress: Double {
        guard !questions.isEmpty else { return 0.0 }
        return Double(selectedAnswers.count) / Double(questions.count)
    }

    func selectAnswer(questionId: Int, score: Int) {
        selectedAnswers[questionId] = score
    }

    @MainActor
    func saveResult() async {
        let result = CareerAssessmentResultEntity()
        do {
            try await saveResultUseCase.execute(result)
            isCompleted = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
