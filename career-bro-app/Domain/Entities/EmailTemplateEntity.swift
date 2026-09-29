//
//  EmailTemplateEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct EmailAttachmentEntity: Identifiable, Equatable {
    let id: UUID
    var fileName: String
    var fileSizeString: String
    
    init(id: UUID = UUID(), fileName: String, fileSizeString: String = "200 KB") {
        self.id = id
        self.fileName = fileName
        self.fileSizeString = fileSizeString
    }
}

struct EmailTemplateEntity: Identifiable, Equatable {
    let id: UUID
    var title: String
    var tags: [String]
    var subject: String
    var body: String
    var attachments: [EmailAttachmentEntity]
    
    init(
        id: UUID = UUID(),
        title: String,
        tags: [String] = [],
        subject: String = "",
        body: String = "",
        attachments: [EmailAttachmentEntity] = [
            EmailAttachmentEntity(fileName: "CV.pdf", fileSizeString: "200 KB"),
            EmailAttachmentEntity(fileName: "portfolio.pdf", fileSizeString: "200 KB")
        ]
    ) {
        self.id = id
        self.title = title
        self.tags = tags
        self.subject = subject
        self.body = body
        self.attachments = attachments
    }
}
