//
//  ChatMessageEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct ChatAttachmentEntity: Identifiable, Equatable {
    let id: UUID
    var fileName: String
    var fileSize: String
    var fileType: String

    init(
        id: UUID = UUID(),
        fileName: String,
        fileSize: String,
        fileType: String = "PDF"
    ) {
        self.id = id
        self.fileName = fileName
        self.fileSize = fileSize
        self.fileType = fileType
    }
}

struct ChatMessageEntity: Identifiable, Equatable {
    let id: UUID
    var text: String
    var isUser: Bool
    var timestamp: Date
    var attachment: ChatAttachmentEntity?

    init(
        id: UUID = UUID(),
        text: String,
        isUser: Bool,
        timestamp: Date = Date(),
        attachment: ChatAttachmentEntity? = nil
    ) {
        self.id = id
        self.text = text
        self.isUser = isUser
        self.timestamp = timestamp
        self.attachment = attachment
    }
}

struct ChatSessionEntity: Identifiable, Equatable {
    let id: UUID
    var title: String
    var preview: String
    var date: Date
    var isPinned: Bool

    init(
        id: UUID = UUID(),
        title: String,
        preview: String,
        date: Date = Date(),
        isPinned: Bool = false
    ) {
        self.id = id
        self.title = title
        self.preview = preview
        self.date = date
        self.isPinned = isPinned
    }
}
