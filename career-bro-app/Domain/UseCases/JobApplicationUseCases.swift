//
//  JobApplicationUseCases.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct GetJobApplicationsUseCase {
    private let repository: JobApplicationRepositoryProtocol

    init(repository: JobApplicationRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [JobApplicationEntity] {
        try await repository.getApplications()
    }
}

struct SaveJobApplicationUseCase {
    private let repository: JobApplicationRepositoryProtocol

    init(repository: JobApplicationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ application: JobApplicationEntity) async throws {
        try await repository.saveApplication(application)
    }
}

struct UpdateJobApplicationUseCase {
    private let repository: JobApplicationRepositoryProtocol

    init(repository: JobApplicationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ application: JobApplicationEntity) async throws {
        try await repository.updateApplication(application)
    }
}

struct DeleteJobApplicationUseCase {
    private let repository: JobApplicationRepositoryProtocol

    init(repository: JobApplicationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(_ id: UUID) async throws {
        try await repository.deleteApplication(id)
    }
}

struct UpdateJobStageUseCase {
    private let repository: JobApplicationRepositoryProtocol

    init(repository: JobApplicationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(applicationId: UUID, newIndex: Int) async throws {
        try await repository.updateStageIndex(for: applicationId, newIndex: newIndex)
    }
}
