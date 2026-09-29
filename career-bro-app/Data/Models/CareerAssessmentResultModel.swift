//
//  CareerAssessmentResultModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

@Model
final class CareerAssessmentResultModel {
    @Attribute(.unique) var id: UUID
    var primaryArchetype: String
    var archetypeDescription: String
    var matchPercentage: Int
    var completedDate: Date
    var roadmapStages: [String]
    var workPreferences: [String]
    
    init(
        id: UUID = UUID(),
        primaryArchetype: String = "The Strategic Builder",
        archetypeDescription: String = "You thrive at the intersection of product vision, engineering execution, and user empathy.",
        matchPercentage: Int = 94,
        completedDate: Date = Date(),
        roadmapStages: [String] = [
            "Master Micro-Frontends & Distributed Systems",
            "Lead Cross-Functional Product Discovery Sprints",
            "Publish Thought Leadership on Modular Design"
        ],
        workPreferences: [String] = ["High Autonomy", "Async-First", "High Impact Projects"]
    ) {
        self.id = id
        self.primaryArchetype = primaryArchetype
        self.archetypeDescription = archetypeDescription
        self.matchPercentage = matchPercentage
        self.completedDate = completedDate
        self.roadmapStages = roadmapStages
        self.workPreferences = workPreferences
    }
}
