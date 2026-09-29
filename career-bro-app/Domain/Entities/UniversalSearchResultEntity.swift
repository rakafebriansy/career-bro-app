//
//  UniversalSearchResultEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

enum SearchResultCategoryEnum: String, CaseIterable, Identifiable, Codable {
    case all = "Semua"
    case navigation = "Menu & Navigasi"
    case jobs = "Lamaran Kerja"
    case emails = "Template Surat"
    case chats = "Robo Chat & Persona"
    case careerDNA = "Career DNA & Asesmen"
    case settings = "Pengaturan & Token"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .all: return "square.grid.2x2"
        case .navigation: return "arrow.triangle.branch"
        case .jobs: return "briefcase.fill"
        case .emails: return "envelope.fill"
        case .chats: return "sparkles"
        case .careerDNA: return "map.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

enum SearchNavigationDestination: Hashable, Identifiable {
    case tab(index: Int)
    case jobDetail(id: UUID, company: String, position: String)
    case emailDetail(id: UUID, title: String)
    case salaryPredictor
    case cvReview
    case careerAssessment
    case careerDNA
    case roboChat(initialPrompt: String?)
    case tokenHistory
    case upgradePlan
    case profile
    case editProfile
    case resetData

    var id: String {
        switch self {
        case .tab(let idx): return "tab_\(idx)"
        case .jobDetail(let id, _, _): return "job_\(id)"
        case .emailDetail(let id, _): return "email_\(id)"
        case .salaryPredictor: return "salaryPredictor"
        case .cvReview: return "cvReview"
        case .careerAssessment: return "careerAssessment"
        case .careerDNA: return "careerDNA"
        case .roboChat(let p): return "roboChat_\(p ?? "")"
        case .tokenHistory: return "tokenHistory"
        case .upgradePlan: return "upgradePlan"
        case .profile: return "profile"
        case .editProfile: return "editProfile"
        case .resetData: return "resetData"
        }
    }
}

struct UniversalSearchResultEntity: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let category: SearchResultCategoryEnum
    let systemImage: String
    let badgeText: String?
    let badgeColorHex: String
    let destination: SearchNavigationDestination
    let matchScore: Int

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        category: SearchResultCategoryEnum,
        systemImage: String,
        badgeText: String? = nil,
        badgeColorHex: String = "4F46E5",
        destination: SearchNavigationDestination,
        matchScore: Int = 100
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.systemImage = systemImage
        self.badgeText = badgeText
        self.badgeColorHex = badgeColorHex
        self.destination = destination
        self.matchScore = matchScore
    }
}
