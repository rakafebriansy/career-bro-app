//
//  ProfileViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class ProfileViewModel {
    var profile: UserProfileEntity = UserProfileEntity()
    var isEditPresented: Bool = false
    var isLogoutAlertPresented: Bool = false
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let getUserProfileUseCase: GetUserProfileUseCase
    private let updateUserProfileUseCase: UpdateUserProfileUseCase

    init(
        getUserProfileUseCase: GetUserProfileUseCase = GetUserProfileUseCase(repository: UserProfileRepository()),
        updateUserProfileUseCase: UpdateUserProfileUseCase = UpdateUserProfileUseCase(repository: UserProfileRepository())
    ) {
        self.getUserProfileUseCase = getUserProfileUseCase
        self.updateUserProfileUseCase = updateUserProfileUseCase
    }

    @MainActor
    func loadProfile() async {
        isLoading = true
        errorMessage = nil
        do {
            profile = try await getUserProfileUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    @MainActor
    func toggleNotifications() async {
        profile.isNotificationsEnabled.toggle()
        do {
            try await updateUserProfileUseCase.execute(profile)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    func toggleDarkMode() async {
        profile.isDarkModeEnabled.toggle()
        do {
            try await updateUserProfileUseCase.execute(profile)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
