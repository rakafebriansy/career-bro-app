//
//  LocalUserProfileDataSource.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

protocol LocalUserProfileDataSourceProtocol {
    func getProfile() -> UserProfileEntity
    func updateProfile(_ profile: UserProfileEntity)
}

final class LocalUserProfileDataSource: LocalUserProfileDataSourceProtocol {
    private let modelContext: ModelContext?
    private var inMemoryProfile: UserProfileEntity

    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
        self.inMemoryProfile = UserProfileEntity(
            fullName: "Raka Febrian Syahputra",
            email: "rakafebrian.sy@gmail.com",
            phoneNumber: "+62 812-3456-7890",
            location: "Jakarta, Indonesia",
            currentRole: "Senior iOS & AI Engineer",
            bio: "Passionate engineer building high performance iOS apps with SwiftData and clean architecture.",
            avatarImageName: nil,
            isNotificationsEnabled: true,
            isDarkModeEnabled: false
        )
    }

    func getProfile() -> UserProfileEntity {
        if let context = modelContext {
            let descriptor = FetchDescriptor<UserProfileModel>()
            if let model = try? context.fetch(descriptor).first {
                return UserProfileEntity(
                    id: model.id,
                    fullName: model.fullName,
                    email: model.email,
                    phoneNumber: model.phoneNumber,
                    location: model.location,
                    currentRole: model.currentRole,
                    bio: model.bio,
                    avatarImageName: model.avatarImageName,
                    isNotificationsEnabled: model.isNotificationsEnabled,
                    isDarkModeEnabled: model.isDarkModeEnabled
                )
            }
        }
        return inMemoryProfile
    }

    func updateProfile(_ profile: UserProfileEntity) {
        inMemoryProfile = profile
        if let context = modelContext {
            let descriptor = FetchDescriptor<UserProfileModel>()
            if let existing = try? context.fetch(descriptor).first {
                existing.fullName = profile.fullName
                existing.email = profile.email
                existing.phoneNumber = profile.phoneNumber
                existing.location = profile.location
                existing.currentRole = profile.currentRole
                existing.bio = profile.bio
                existing.avatarImageName = profile.avatarImageName
                existing.isNotificationsEnabled = profile.isNotificationsEnabled
                existing.isDarkModeEnabled = profile.isDarkModeEnabled
            } else {
                let model = UserProfileModel(
                    id: profile.id,
                    fullName: profile.fullName,
                    email: profile.email,
                    phoneNumber: profile.phoneNumber,
                    location: profile.location,
                    currentRole: profile.currentRole,
                    bio: profile.bio,
                    avatarImageName: profile.avatarImageName,
                    isNotificationsEnabled: profile.isNotificationsEnabled,
                    isDarkModeEnabled: profile.isDarkModeEnabled
                )
                context.insert(model)
            }
            try? context.save()
        }
    }
}
