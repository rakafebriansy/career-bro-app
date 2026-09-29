//
//  CareerAssessmentEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct CareerAssessmentQuestionEntity: Identifiable, Codable, Equatable {
    let id: Int
    let question: String
    let category: String?
    var selectedScore: Int?
    
    init(id: Int, question: String, category: String? = nil, selectedScore: Int? = nil) {
        self.id = id
        self.question = question
        self.category = category
        self.selectedScore = selectedScore
    }
}

struct CareerAssessmentResultEntity: Identifiable, Equatable {
    let id: UUID
    var primaryArchetype: String
    var archetypeDescription: String
    var matchPercentage: Int
    var scores: [String: Double]
    var recommendedRoadmap: [String]
    var workPreferences: [String]
    var completedDate: Date
    
    init(
        id: UUID = UUID(),
        primaryArchetype: String = "The Strategic Builder",
        archetypeDescription: String = "You thrive at the intersection of product vision, engineering execution, and user empathy.",
        matchPercentage: Int = 94,
        scores: [String: Double] = [
            "Leadership": 85.0,
            "Technical Execution": 92.0,
            "Product Strategy": 88.0,
            "User Research": 78.0,
            "System Architecture": 95.0
        ],
        recommendedRoadmap: [String] = [
            "Master Micro-Frontends & Distributed Systems",
            "Lead Cross-Functional Product Discovery Sprints",
            "Publish Thought Leadership on Modular Design"
        ],
        workPreferences: [String] = ["High Autonomy", "Async-First", "High Impact Projects"],
        completedDate: Date = Date()
    ) {
        self.id = id
        self.primaryArchetype = primaryArchetype
        self.archetypeDescription = archetypeDescription
        self.matchPercentage = matchPercentage
        self.scores = scores
        self.recommendedRoadmap = recommendedRoadmap
        self.workPreferences = workPreferences
        self.completedDate = completedDate
    }
}
