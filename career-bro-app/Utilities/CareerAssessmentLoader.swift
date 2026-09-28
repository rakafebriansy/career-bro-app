//
//  CareerAssessmentLoader.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

enum CareerAssessmentLoader {
    static func loadQuestions(from filename: String = "career_assessment_questions") -> [CareerAssessmentQuestionModel] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return []
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return []
        }
        
        guard let questions = try? JSONDecoder().decode([CareerAssessmentQuestionModel].self, from: data) else {
            return []
        }
        
        return questions
    }
}
