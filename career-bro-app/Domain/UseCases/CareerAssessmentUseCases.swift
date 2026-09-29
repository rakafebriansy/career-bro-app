//
//  CareerAssessmentUseCases.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct GetCareerAssessmentQuestionsUseCase {
    private let repository: CareerAssessmentRepositoryProtocol

    init(repository: CareerAssessmentRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [CareerAssessmentQuestionEntity] {
        try await repository.getAssessmentQuestions()
    }
}

struct GetLatestCareerAssessmentResultUseCase {
    private let repository: CareerAssessmentRepositoryProtocol

    init(repository: CareerAssessmentRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> CareerAssessmentResultEntity? {
        try await repository.getLatestResult()
    }
}

struct SaveCareerAssessmentResultUseCase {
    private let repository: CareerAssessmentRepositoryProtocol

    init(repository: CareerAssessmentRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ result: CareerAssessmentResultEntity) async throws {
        try await repository.saveAssessmentResult(result)
    }
}
