//
//  UserProfileEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct UserProfileEntity: Identifiable, Equatable {
    let id: UUID
    var fullName: String
    var email: String
    var phoneNumber: String
    var location: String
    var currentRole: String
    var bio: String
    var avatarImageName: String?
    var isNotificationsEnabled: Bool
    var isDarkModeEnabled: Bool
    
    init(
        id: UUID = UUID(),
        fullName: String = "Raka Febrian Syahputra",
        email: String = "rakafebrian.sy@gmail.com",
        phoneNumber: String = "+62 812-3456-7890",
        location: String = "Jakarta, Indonesia",
        currentRole: String = "Senior iOS & AI Engineer",
        bio: String = "Passionate engineer building high performance iOS apps with SwiftData and clean architecture.",
        avatarImageName: String? = nil,
        isNotificationsEnabled: Bool = true,
        isDarkModeEnabled: Bool = false
    ) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.location = location
        self.currentRole = currentRole
        self.bio = bio
        self.avatarImageName = avatarImageName
        self.isNotificationsEnabled = isNotificationsEnabled
        self.isDarkModeEnabled = isDarkModeEnabled
    }
}
