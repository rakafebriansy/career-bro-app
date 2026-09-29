//
//  EditProfileViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class EditProfileViewModel {
    var fullName: String
    var email: String
    var phoneNumber: String
    var location: String
    var currentRole: String
    var bio: String
    var isSuccess: Bool = false
    var errorMessage: String? = nil

    private let updateUserProfileUseCase: UpdateUserProfileUseCase
    private var originalProfile: UserProfileEntity

    init(
        profile: UserProfileEntity,
        updateUserProfileUseCase: UpdateUserProfileUseCase = UpdateUserProfileUseCase(repository: UserProfileRepository())
    ) {
        self.originalProfile = profile
        self.fullName = profile.fullName
        self.email = profile.email
        self.phoneNumber = profile.phoneNumber
        self.location = profile.location
        self.currentRole = profile.currentRole
        self.bio = profile.bio
        self.updateUserProfileUseCase = updateUserProfileUseCase
    }

    @MainActor
    func saveProfile() async {
        guard !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Full name cannot be empty."
            return
        }

        var updated = originalProfile
        updated.fullName = fullName
        updated.email = email
        updated.phoneNumber = phoneNumber
        updated.location = location
        updated.currentRole = currentRole
        updated.bio = bio

        do {
            try await updateUserProfileUseCase.execute(updated)
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
