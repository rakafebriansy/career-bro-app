import Foundation

struct CareerAssessmentQuestionModel: Identifiable, Codable, Equatable {
    let id: Int
    let question: String
    let category: String?
}
