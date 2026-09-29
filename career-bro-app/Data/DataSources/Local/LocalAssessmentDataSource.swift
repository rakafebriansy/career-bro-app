//
//  LocalAssessmentDataSource.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

protocol LocalAssessmentDataSourceProtocol {
    func loadQuestions() -> [CareerAssessmentQuestionEntity]
    func getLatestResult() -> CareerAssessmentResultEntity?
    func saveResult(_ result: CareerAssessmentResultEntity)
}

final class LocalAssessmentDataSource: LocalAssessmentDataSourceProtocol {
    private let modelContext: ModelContext?
    private var cachedResult: CareerAssessmentResultEntity?
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
        self.cachedResult = CareerAssessmentResultEntity()
    }
    
    func loadQuestions() -> [CareerAssessmentQuestionEntity] {
        let loaded = CareerAssessmentLoader.loadQuestions()
        return loaded.map { q in
            CareerAssessmentQuestionEntity(
                id: q.id,
                question: q.question,
                category: q.category
            )
        }
    }
    
    func getLatestResult() -> CareerAssessmentResultEntity? {
        if let context = modelContext {
            let descriptor = FetchDescriptor<CareerAssessmentResultModel>(sortBy: [SortDescriptor(\.completedDate, order: .reverse)])
            if let model = try? context.fetch(descriptor).first {
                return CareerAssessmentResultEntity(
                    id: model.id,
                    primaryArchetype: model.primaryArchetype,
                    archetypeDescription: model.archetypeDescription,
                    matchPercentage: model.matchPercentage,
                    scores: [
                        "Leadership": 85.0,
                        "Technical Execution": 92.0,
                        "Product Strategy": 88.0,
                        "User Research": 78.0,
                        "System Architecture": 95.0
                    ],
                    recommendedRoadmap: model.roadmapStages,
                    workPreferences: model.workPreferences,
                    completedDate: model.completedDate
                )
            }
        }
        return cachedResult
    }
    
    func saveResult(_ result: CareerAssessmentResultEntity) {
        cachedResult = result
        if let context = modelContext {
            let model = CareerAssessmentResultModel(
                id: result.id,
                primaryArchetype: result.primaryArchetype,
                archetypeDescription: result.archetypeDescription,
                matchPercentage: result.matchPercentage,
                completedDate: result.completedDate,
                roadmapStages: result.recommendedRoadmap,
                workPreferences: result.workPreferences
            )
            context.insert(model)
            try? context.save()
        }
    }
}
