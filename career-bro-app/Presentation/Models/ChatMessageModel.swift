//
//  ChatMessageModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct ChatAttachmentModel: Identifiable, Equatable {
    let id: UUID
    let fileName: String
    let fileSize: String
    
    init(id: UUID = UUID(), fileName: String, fileSize: String) {
        self.id = id
        self.fileName = fileName
        self.fileSize = fileSize
    }
}

struct ChatMessageModel: Identifiable, Equatable {
    let id: UUID
    let text: String
    let isUser: Bool
    let timestamp: Date
    let attachment: ChatAttachmentModel?
    
    init(
        id: UUID = UUID(),
        text: String,
        isUser: Bool,
        timestamp: Date = Date(),
        attachment: ChatAttachmentModel? = nil
    ) {
        self.id = id
        self.text = text
        self.isUser = isUser
        self.timestamp = timestamp
        self.attachment = attachment
    }
    
    static let sampleMockupConversation: [ChatMessageModel] = [
        ChatMessageModel(
            text: "I'm not sure which career path fits me",
            isUser: true
        ),
        ChatMessageModel(
            text: "That's okay, let's find out\n\nwhat you like or what you're best at?",
            isUser: false
        ),
        ChatMessageModel(
            text: "Could you help to review my CV?",
            isUser: true,
            attachment: ChatAttachmentModel(fileName: "Flyer.pdf", fileSize: "200 KB")
        ),
        ChatMessageModel(
            text: "Your CV is excellent, but let’s make it more perfect\n\npart of introduction better be like this\n“Hi, Im Maya, Digital Marketer for 5+ years experience……”",
            isUser: false
        ),
        ChatMessageModel(
            text: "Could u help to prepare my interview for UI/UX role?",
            isUser: true
        ),
        ChatMessageModel(
            text: "Sure, but before that, let’s choose with whom you wanna interview!",
            isUser: false
        )
    ]
}

struct PromptCategoryModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let iconName: String
    let prompts: [String]
    
    static let defaultCategories: [PromptCategoryModel] = [
        PromptCategoryModel(
            title: "Explore Career",
            iconName: "clock",
            prompts: [
                "Help me find the right career path",
                "What skills do I need for my dream job?",
                "Analyze my career potential"
            ]
        ),
        PromptCategoryModel(
            title: "Build & Improve",
            iconName: "pencil",
            prompts: [
                "Improve my CV for this position",
                "Write a professional LinkedIn summary",
                "Review my portfolio and give feedback"
            ]
        ),
        PromptCategoryModel(
            title: "Prepare & Practice",
            iconName: "target",
            prompts: [
                "Simulate a job interview with me",
                "Give me interview questions for UI/UX Designer",
                "How should I answer 'Tell me about yourself'?"
            ]
        )
    ]
}

struct ChatSessionModel: Identifiable {
    let id: UUID = UUID()
    let title: String
    let preview: String
    let date: Date
    
    static let sampleSessions: [ChatSessionModel] = [
        ChatSessionModel(
            title: "Career Path & CV Review",
            preview: "Your CV is excellent, but let’s make it more perfect...",
            date: Date()
        ),
        ChatSessionModel(
            title: "UI/UX Designer Mock Interview",
            preview: "Here are 5 behavioral questions for your upcoming interview...",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        ),
        ChatSessionModel(
            title: "Resume Keyword Optimization",
            preview: "I've optimized your experience bullet points with action verbs...",
            date: Calendar.current.date(byAdding: .day, value: -3, to: Date()) ?? Date()
        )
    ]
}
