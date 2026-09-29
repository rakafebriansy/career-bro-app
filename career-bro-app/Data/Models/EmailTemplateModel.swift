//
//  EmailTemplateModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

struct EmailAttachmentItem: Codable, Identifiable, Hashable {
    var id: UUID
    var fileName: String
    var fileSizeString: String

    init(id: UUID = UUID(), fileName: String, fileSizeString: String = "200 KB") {
        self.id = id
        self.fileName = fileName
        self.fileSizeString = fileSizeString
    }
}

@Model
final class EmailTemplateModel {
    @Attribute(.unique) var id: UUID
    var title: String
    var tags: [String]
    var subject: String
    var body: String
    var attachments: [EmailAttachmentItem]

    init(
        id: UUID = UUID(),
        title: String,
        tags: [String] = [],
        subject: String = "",
        body: String = "",
        attachments: [EmailAttachmentItem] = [
            EmailAttachmentItem(fileName: "CV.pdf", fileSizeString: "200 KB"),
            EmailAttachmentItem(fileName: "portfolio.pdf", fileSizeString: "200 KB")
        ]
    ) {
        self.id = id
        self.title = title
        self.tags = tags
        self.subject = subject
        self.body = body
        self.attachments = attachments
    }

    static var sampleTemplates: [EmailTemplateModel] {
        [
            EmailTemplateModel(
                title: "Template Fullstack",
                tags: ["Fullstack"],
                subject: "Application for Fullstack Engineer - {name}",
                body: "Hello {name}\n\nMy name is Yusrina Hirzi Nur Izza, an Information Systems graduate with a strong interest and practical experience in UI/UX Design. Through this email, I would like to express my interest in joining {company} as a UI/UX Designer.\n\nOver the past year, I have gained hands-on experience through several internships. During these experiences, I was involved in designing web and mobile interfaces, creating user flows, wireframe, prototypes, and collaborating closely with developers and cross-functional teams to deliver user-centered digital products.\n\nI have attached my CV and Portfolio for your review. I would greatly appreciate the opportunity to discuss how my skills and experiences.\n\nThank you for your time and consideration. I look forward to hearing from you.\n\nBest regards,\n\nYusrina Hirzi Nur Izza",
                attachments: [
                    EmailAttachmentItem(fileName: "CV.pdf", fileSizeString: "200 KB"),
                    EmailAttachmentItem(fileName: "portfolio.pdf", fileSizeString: "200 KB")
                ]
            ),
            EmailTemplateModel(
                title: "Template Follow-Up",
                tags: ["Fullstack", "Back-End", "Front-End", "UI/UX"],
                subject: "Following Up on My Application - {name}",
                body: "Dear {company} Hiring Team,\n\nI hope this email finds you well. I am following up on my application for the role submitted recently. I am very enthusiastic about this opportunity and would love to reiterate my interest in joining {company}.\n\nPlease let me know if you need any additional documents or references.\n\nBest regards,\n{name}",
                attachments: [
                    EmailAttachmentItem(fileName: "CV.pdf", fileSizeString: "200 KB")
                ]
            ),
            EmailTemplateModel(
                title: "Template UI/UX Designer",
                tags: ["UI/UX"],
                subject: "Application for UI/UX Designer - {name} Portfolio",
                body: "Hi {company} Design Team,\n\nI'm reaching out to apply for the UI/UX Designer opening at {company}. My design portfolio showcases human-centered interfaces, design systems, and delightful interaction design tailored for web and mobile.\n\nPortfolio: Attached\nResume: Attached\n\nLooking forward to hearing from you!\n\nBest,\n{name}",
                attachments: [
                    EmailAttachmentItem(fileName: "CV.pdf", fileSizeString: "200 KB"),
                    EmailAttachmentItem(fileName: "portfolio.pdf", fileSizeString: "200 KB")
                ]
            ),
            EmailTemplateModel(
                title: "Template Cold Reachout",
                tags: ["Networking", "General"],
                subject: "Exploring Engineering Opportunities at {company} - {name}",
                body: "Dear {name},\n\nI have been following {company}'s recent work and admire your approach to digital innovation. As a passionate developer, I'd love to connect briefly to learn more about your team culture and potential future openings.\n\nThank you for your time,\n{name}",
                attachments: []
            )
        ]
    }
}
