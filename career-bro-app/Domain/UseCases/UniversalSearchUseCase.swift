//
//  UniversalSearchUseCase.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

struct UniversalSearchUseCase {
    func getQuickPicks(modelContext: ModelContext? = nil) -> [UniversalSearchResultEntity] {
        return Array(NavigationMenuCatalog.items.prefix(3).map { item in
            UniversalSearchResultEntity(
                title: item.title,
                subtitle: item.subtitle,
                category: item.category,
                systemImage: item.systemImage,
                badgeText: item.badgeText,
                badgeColorHex: item.badgeColorHex,
                destination: item.destination,
                matchScore: 100
            )
        })
    }

    func execute(
        query: String,
        category: SearchResultCategoryEnum = .all,
        modelContext: ModelContext? = nil
    ) async throws -> [UniversalSearchResultEntity] {
        let cleanQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if cleanQuery.isEmpty && category == .all {
            return []
        }

        var results: [UniversalSearchResultEntity] = []

        guard let context = modelContext else {
            return []
        }

        if category == .navigation || (category == .all && !cleanQuery.isEmpty) {
            for item in NavigationMenuCatalog.items {
                let matchesQuery = cleanQuery.isEmpty ||
                    item.title.lowercased().contains(cleanQuery) ||
                    item.subtitle.lowercased().contains(cleanQuery) ||
                    item.keywords.contains(where: { $0.lowercased().contains(cleanQuery) })

                if matchesQuery {
                    let score = cleanQuery.isEmpty ? 80 : (item.title.lowercased().starts(with: cleanQuery) ? 100 : 80)
                    results.append(UniversalSearchResultEntity(
                        title: item.title,
                        subtitle: item.subtitle,
                        category: item.category,
                        systemImage: item.systemImage,
                        badgeText: item.badgeText,
                        badgeColorHex: item.badgeColorHex,
                        destination: item.destination,
                        matchScore: score
                    ))
                }
            }
        }

        if category == .all || category == .jobs {
            let descriptor = FetchDescriptor<JobApplicationModel>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
            if let applications = try? context.fetch(descriptor) {
                for app in applications {
                    let matchesKeywords = app.keywords?.contains(where: { $0.lowercased().contains(cleanQuery) }) ?? false
                    let matchesLocation = app.location?.lowercased().contains(cleanQuery) ?? false
                    let matchesDesc = app.jobDescription?.lowercased().contains(cleanQuery) ?? false

                    let matchesQuery = cleanQuery.isEmpty ||
                        app.position.lowercased().contains(cleanQuery) ||
                        app.company.lowercased().contains(cleanQuery) ||
                        app.workLocation.rawValue.lowercased().contains(cleanQuery) ||
                        app.status.rawValue.lowercased().contains(cleanQuery) ||
                        app.employment.rawValue.lowercased().contains(cleanQuery) ||
                        matchesLocation ||
                        matchesKeywords ||
                        matchesDesc

                    if matchesQuery {
                        let score = cleanQuery.isEmpty ? 100 : (app.position.lowercased().starts(with: cleanQuery) ? 120 : (app.company.lowercased().starts(with: cleanQuery) ? 115 : 95))
                        results.append(UniversalSearchResultEntity(
                            id: app.id,
                            title: "\(app.position) • \(app.company)",
                            subtitle: "\(app.workLocation.rawValue) • \(app.employment.rawValue) • Status: \(app.status.rawValue)",
                            category: .jobs,
                            systemImage: "briefcase.fill",
                            badgeText: app.status.rawValue,
                            badgeColorHex: app.status.colorHex,
                            destination: .jobDetail(id: app.id, company: app.company, position: app.position),
                            matchScore: score
                        ))
                    }
                }
            }
        }

        if category == .all || category == .emails {
            let descriptor = FetchDescriptor<EmailTemplateModel>(sortBy: [SortDescriptor(\.title)])
            if let templates = try? context.fetch(descriptor) {
                for tpl in templates {
                    let matchesQuery = cleanQuery.isEmpty ||
                        tpl.title.lowercased().contains(cleanQuery) ||
                        tpl.subject.lowercased().contains(cleanQuery) ||
                        tpl.body.lowercased().contains(cleanQuery) ||
                        tpl.tags.contains(where: { $0.lowercased().contains(cleanQuery) })

                    if matchesQuery {
                        let tagLabel = tpl.tags.first ?? "Template"
                        let score = cleanQuery.isEmpty ? 95 : (tpl.title.lowercased().starts(with: cleanQuery) ? 110 : 90)
                        results.append(UniversalSearchResultEntity(
                            id: tpl.id,
                            title: tpl.title,
                            subtitle: "Subjek: \(tpl.subject) • \(tpl.body.prefix(60))...",
                            category: .emails,
                            systemImage: "envelope.fill",
                            badgeText: tagLabel,
                            badgeColorHex: "6366F1",
                            destination: .emailDetail(id: tpl.id, title: tpl.title),
                            matchScore: score
                        ))
                    }
                }
            }
        }

        if category == .all || category == .chats {
            let sessionDescriptor = FetchDescriptor<ChatSessionModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            if let sessions = try? context.fetch(sessionDescriptor) {
                for s in sessions {
                    let matchesQuery = cleanQuery.isEmpty ||
                        s.title.lowercased().contains(cleanQuery) ||
                        s.preview.lowercased().contains(cleanQuery)

                    if matchesQuery {
                        let score = cleanQuery.isEmpty ? 85 : (s.title.lowercased().starts(with: cleanQuery) ? 100 : 80)
                        results.append(UniversalSearchResultEntity(
                            id: s.id,
                            title: s.title,
                            subtitle: s.preview,
                            category: .chats,
                            systemImage: "message.fill",
                            badgeText: s.isPinned ? "Disematkan" : "Riwayat",
                            badgeColorHex: "8B5CF6",
                            destination: .roboChat(initialPrompt: nil),
                            matchScore: score
                        ))
                    }
                }
            }

            if !cleanQuery.isEmpty {
                let messageDescriptor = FetchDescriptor<ChatMessageItemModel>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
                if let messages = try? context.fetch(messageDescriptor) {
                    for msg in messages {
                        if msg.text.lowercased().contains(cleanQuery) {
                            results.append(UniversalSearchResultEntity(
                                id: msg.id,
                                title: msg.isUser ? "Pesan Anda" : "Balasan Robo AI",
                                subtitle: msg.text,
                                category: .chats,
                                systemImage: msg.isUser ? "person.fill" : "sparkles",
                                badgeText: msg.isUser ? "User" : "Robo AI",
                                badgeColorHex: msg.isUser ? "3B82F6" : "8B5CF6",
                                destination: .roboChat(initialPrompt: nil),
                                matchScore: 75
                            ))
                        }
                    }
                }
            }
        }

        if category == .all || category == .careerDNA {
            let descriptor = FetchDescriptor<CareerAssessmentResultModel>(sortBy: [SortDescriptor(\.completedDate, order: .reverse)])
            if let assessmentResults = try? context.fetch(descriptor) {
                for result in assessmentResults {
                    let matchesQuery = cleanQuery.isEmpty ||
                        result.primaryArchetype.lowercased().contains(cleanQuery) ||
                        result.archetypeDescription.lowercased().contains(cleanQuery) ||
                        result.roadmapStages.contains(where: { $0.lowercased().contains(cleanQuery) }) ||
                        result.workPreferences.contains(where: { $0.lowercased().contains(cleanQuery) })

                    if matchesQuery {
                        let score = cleanQuery.isEmpty ? 95 : 110
                        results.append(UniversalSearchResultEntity(
                            id: result.id,
                            title: "Career DNA: \(result.primaryArchetype)",
                            subtitle: "\(result.archetypeDescription) • Roadmap: \(result.roadmapStages.joined(separator: ", "))",
                            category: .careerDNA,
                            systemImage: "star.hexagonpath.fill",
                            badgeText: "\(result.matchPercentage)% Match",
                            badgeColorHex: "10B981",
                            destination: .careerDNA,
                            matchScore: score
                        ))
                    }
                }
            }
        }

        if category == .all || category == .settings {
            let profileDescriptor = FetchDescriptor<UserProfileModel>()
            if let profiles = try? context.fetch(profileDescriptor) {
                for profile in profiles {
                    let matchesQuery = cleanQuery.isEmpty ||
                        profile.fullName.lowercased().contains(cleanQuery) ||
                        profile.email.lowercased().contains(cleanQuery) ||
                        profile.currentRole.lowercased().contains(cleanQuery) ||
                        profile.bio.lowercased().contains(cleanQuery) ||
                        profile.location.lowercased().contains(cleanQuery)

                    if matchesQuery {
                        let score = cleanQuery.isEmpty ? 90 : 95
                        results.append(UniversalSearchResultEntity(
                            id: profile.id,
                            title: "Profil: \(profile.fullName)",
                            subtitle: "\(profile.currentRole) • \(profile.email) • \(profile.location)",
                            category: .settings,
                            systemImage: "person.text.rectangle.fill",
                            badgeText: "Akun",
                            badgeColorHex: "6B7280",
                            destination: .editProfile,
                            matchScore: score
                        ))
                    }
                }
            }

            let tokenDescriptor = FetchDescriptor<TokenBalanceModel>()
            if let tokens = try? context.fetch(tokenDescriptor) {
                for token in tokens {
                    let matchesQuery = cleanQuery.isEmpty ||
                        "token".contains(cleanQuery) ||
                        "saldo".contains(cleanQuery) ||
                        "kuota".contains(cleanQuery) ||
                        token.customProvider.lowercased().contains(cleanQuery)

                    if matchesQuery {
                        let score = cleanQuery.isEmpty ? 85 : 88
                        results.append(UniversalSearchResultEntity(
                            id: token.id,
                            title: "Saldo AI Token: \(token.remainingTokens) / \(token.totalQuota)",
                            subtitle: "Provider: \(token.customProvider) • Custom Key: \(token.isCustomKeyEnabled ? "Aktif" : "Nonaktif")",
                            category: .settings,
                            systemImage: "sparkle",
                            badgeText: "\(token.remainingTokens) Token",
                            badgeColorHex: "F59E0B",
                            destination: .tokenHistory,
                            matchScore: score
                        ))
                    }
                }
            }
        }

        return results.sorted {
            if $0.matchScore != $1.matchScore {
                return $0.matchScore > $1.matchScore
            }
            return $0.title < $1.title
        }
    }
}
