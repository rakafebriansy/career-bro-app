//
//  JobStatusEnum.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import Foundation
import SwiftUI

enum JobStatusEnum: String, Codable, CaseIterable {
    case needToApply = "Need To Apply"
    case applied = "Applied"
    case assessment = "Assessment"
    case interview = "Interview"
    case postInterview = "Post-Interview"
    case offered = "Offered"
    case accepted = "Accepted"
    case rejected = "Rejected"
    case ghosted = "Ghosted (No Reply)"
    
    var color: Color {
        switch self {
        case .needToApply:
            return Color(hex: "8E5CA6")
        case .applied:
            return Color(hex: "2E9D7E")
        case .assessment:
            return Color(hex: "D9A21B")
        case .interview:
            return Color(hex: "F27F1B")
        case .postInterview:
            return Color(hex: "FFBFF0")
        case .offered:
            return Color(hex: "68BF30")
        case .accepted:
            return Color(hex: "1B8754")
        case .rejected:
            return Color(hex: "D93838")
        case .ghosted:
            return Color(hex: "737373")
        }
    }
}
