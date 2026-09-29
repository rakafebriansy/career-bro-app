//
//  UserProfileUseCases.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct GetUserProfileUseCase {
    private let repository: UserProfileRepositoryProtocol

    init(repository: UserProfileRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> UserProfileEntity {
        try await repository.getUserProfile()
    }
}

struct UpdateUserProfileUseCase {
    private let repository: UserProfileRepositoryProtocol

    init(repository: UserProfileRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ profile: UserProfileEntity) async throws {
        try await repository.updateUserProfile(profile)
    }
}
