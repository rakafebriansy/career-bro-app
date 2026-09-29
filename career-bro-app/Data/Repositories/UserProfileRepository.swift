//
//  UserProfileRepository.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol UserProfileRepositoryProtocol {
    func getUserProfile() async throws -> UserProfileEntity
    func updateUserProfile(_ profile: UserProfileEntity) async throws
}

final class UserProfileRepository: UserProfileRepositoryProtocol {
    private let dataSource: LocalUserProfileDataSourceProtocol

    init(dataSource: LocalUserProfileDataSourceProtocol = LocalUserProfileDataSource()) {
        self.dataSource = dataSource
    }

    func getUserProfile() async throws -> UserProfileEntity {
        return dataSource.getProfile()
    }

    func updateUserProfile(_ profile: UserProfileEntity) async throws {
        dataSource.updateProfile(profile)
    }
}
