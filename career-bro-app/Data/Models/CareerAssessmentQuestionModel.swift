//
//  CareerAssessmentQuestionModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct CareerAssessmentQuestionModel: Identifiable, Codable, Equatable {
    let id: Int
    let question: String
    let category: String?
}
