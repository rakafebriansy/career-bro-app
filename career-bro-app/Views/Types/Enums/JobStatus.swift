//
//  JobStatus.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import Foundation
import SwiftUI

enum JobStatus: String, Codable, CaseIterable {
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
            return Color(hex: "8E5CA6") // Muted Purple (Initial planning)
        case .applied:
            return Color(hex: "2E9D7E") // Mint/Teal Green (Submitted)
        case .assessment:
            return Color(hex: "D9A21B") // Mustard Yellow (Test/Focus phase)
        case .interview:
            return Color(hex: "F27F1B") // Warm Orange (Interview phase)
        case .postInterview:
            return Color(hex: "FFBFF0") // Amber (After Interview phase)
        case .offered:
            return Color(hex: "68BF30") // Lime Green (Good news)
        case .accepted:
            return Color(hex: "1B8754") // Emerald Green (Job accepted)
        case .rejected:
            return Color(hex: "D93838") // Bold Red (Rejected)
        case .ghosted:
            return Color(hex: "737373") // Slate Gray (No response)
        }
    }
}
