//
//  InterviewerPersonaModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct InterviewerPersonaModel: Identifiable, Equatable {
    let id: UUID
    let name: String
    let roleDescription: String
    let bgColorHex: String
    let iconName: String
    
    init(
        id: UUID = UUID(),
        name: String,
        roleDescription: String = "",
        bgColorHex: String,
        iconName: String
    ) {
        self.id = id
        self.name = name
        self.roleDescription = roleDescription
        self.bgColorHex = bgColorHex
        self.iconName = iconName
    }
    
    static let samplePersonas: [InterviewerPersonaModel] = [
        InterviewerPersonaModel(
            name: "Tech Lead",
            roleDescription: "Technical Architecture & System Design",
            bgColorHex: "E5E7EB",
            iconName: "person.crop.circle"
        ),
        InterviewerPersonaModel(
            name: "Tech Lead",
            roleDescription: "Coding & Problem Solving",
            bgColorHex: "EDE9FE",
            iconName: "person.crop.circle.fill"
        ),
        InterviewerPersonaModel(
            name: "HR",
            roleDescription: "Culture Fit & Behavioral Evaluation",
            bgColorHex: "DCFCE7",
            iconName: "person.crop.circle.badge.checkmark"
        ),
        InterviewerPersonaModel(
            name: "Tech Lead",
            roleDescription: "Team Collaboration & Engineering Standards",
            bgColorHex: "EDE9FE",
            iconName: "person.crop.circle.fill"
        ),
        InterviewerPersonaModel(
            name: "Tech Lead",
            roleDescription: "Peer Review & Product Thinking",
            bgColorHex: "EDE9FE",
            iconName: "person.crop.circle.fill"
        )
    ]
}
