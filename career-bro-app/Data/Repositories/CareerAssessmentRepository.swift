//
//  CareerAssessmentRepository.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol CareerAssessmentRepositoryProtocol {
    func getAssessmentQuestions() async throws -> [CareerAssessmentQuestionEntity]
    func getLatestResult() async throws -> CareerAssessmentResultEntity?
    func saveAssessmentResult(_ result: CareerAssessmentResultEntity) async throws
}

final class CareerAssessmentRepository: CareerAssessmentRepositoryProtocol {
    private let dataSource: LocalAssessmentDataSourceProtocol

    init(dataSource: LocalAssessmentDataSourceProtocol = LocalAssessmentDataSource()) {
        self.dataSource = dataSource
    }

    func getAssessmentQuestions() async throws -> [CareerAssessmentQuestionEntity] {
        return dataSource.loadQuestions()
    }

    func getLatestResult() async throws -> CareerAssessmentResultEntity? {
        return dataSource.getLatestResult()
    }

    func saveAssessmentResult(_ result: CareerAssessmentResultEntity) async throws {
        dataSource.saveResult(result)
    }
}
