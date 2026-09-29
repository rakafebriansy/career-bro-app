//
//  LocalChatDataSource.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

protocol LocalChatDataSourceProtocol {
    func getChatSessions() -> [ChatSessionEntity]
    func getPersonas() -> [InterviewerPersonaEntity]
    func saveSession(_ session: ChatSessionEntity)
}

final class LocalChatDataSource: LocalChatDataSourceProtocol {
    private let modelContext: ModelContext?
    private var inMemorySessions: [ChatSessionEntity] = [
        ChatSessionEntity(title: "CV Review & Optimization", preview: "Your CV is excellent, but let’s make it more perfect...", date: Date(), isPinned: true),
        ChatSessionEntity(title: "Portfolio Project Feedback", preview: "Here are 3 key UX improvements for your case study.", date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), isPinned: true),
        ChatSessionEntity(title: "System Architecture Mock Interview", preview: "Great explanation of clean architecture in iOS.", date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date(), isPinned: false),
        ChatSessionEntity(title: "Salary Negotiation Strategy", preview: "Always base your counter-offer on market value data.", date: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(), isPinned: false)
    ]

    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }

    func getChatSessions() -> [ChatSessionEntity] {
        if let context = modelContext {
            let descriptor = FetchDescriptor<ChatSessionModel>(sortBy: [SortDescriptor(\.date, order: .reverse)])
            if let models = try? context.fetch(descriptor), !models.isEmpty {
                return models.map {
                    ChatSessionEntity(
                        id: $0.id,
                        title: $0.title,
                        preview: $0.preview,
                        date: $0.date,
                        isPinned: $0.isPinned
                    )
                }
            }
        }
        return inMemorySessions
    }

    func saveSession(_ session: ChatSessionEntity) {
        if let context = modelContext {
            let targetId = session.id
            let descriptor = FetchDescriptor<ChatSessionModel>(predicate: #Predicate { $0.id == targetId })
            if let existing = try? context.fetch(descriptor).first {
                existing.title = session.title
                existing.preview = session.preview
                existing.date = session.date
                existing.isPinned = session.isPinned
            } else {
                let model = ChatSessionModel(
                    id: session.id,
                    title: session.title,
                    preview: session.preview,
                    date: session.date,
                    isPinned: session.isPinned
                )
                context.insert(model)
            }
            try? context.save()
        } else {
            if let index = inMemorySessions.firstIndex(where: { $0.id == session.id }) {
                inMemorySessions[index] = session
            } else {
                inMemorySessions.insert(session, at: 0)
            }
        }
    }

    func getPersonas() -> [InterviewerPersonaEntity] {
        return [
            InterviewerPersonaEntity(name: "Tech Lead", roleDescription: "Technical architecture, iOS, Swift, and clean code deep dives.", avatarImageName: "person.crop.circle.badge.checkmark", systemPrompt: "You are a pragmatic Tech Lead conducting a rigorous iOS engineering interview."),
            InterviewerPersonaEntity(name: "HR Manager", roleDescription: "Behavioral questions, culture fit, and conflict resolution.", avatarImageName: "person.2.crop.square.stack", systemPrompt: "You are an experienced HR recruiter assessing cultural alignment using the STAR method."),
            InterviewerPersonaEntity(name: "Product Manager", roleDescription: "Product metrics, feature prioritization, and user empathy.", avatarImageName: "chart.bar.doc.horizontal", systemPrompt: "You are a Senior PM testing product sense and metric estimation."),
            InterviewerPersonaEntity(name: "Career Coach", roleDescription: "Resume feedback, compensation negotiation, and growth advice.", avatarImageName: "star.circle.fill", systemPrompt: "You are an executive career advisor helping candidates land top-tier offers.")
        ]
    }
}
