//
//  PriorityEnum.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI

enum PriorityEnum: String, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"

    var backgroundColor: Color {
        switch self {
        case .high:   return Color(hex: "FEE1E0")
        case .medium: return Color(hex: "FEF5E0")
        case .low:    return Color(hex: "E6F7ED")
        }
    }

    var foregroundColor: Color {
        switch self {
        case .high:   return Color(hex: "F33131")
        case .medium: return Color(hex: "F39831")
        case .low:    return Color(hex: "1A8245")
        }
    }
}
