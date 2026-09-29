//
//  InterviewerPersonaEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct InterviewerPersonaEntity: Identifiable, Equatable {
    let id: UUID
    var name: String
    var roleDescription: String
    var avatarImageName: String?
    var systemPrompt: String
    
    init(
        id: UUID = UUID(),
        name: String,
        roleDescription: String,
        avatarImageName: String? = nil,
        systemPrompt: String = ""
    ) {
        self.id = id
        self.name = name
        self.roleDescription = roleDescription
        self.avatarImageName = avatarImageName
        self.systemPrompt = systemPrompt
    }
}
