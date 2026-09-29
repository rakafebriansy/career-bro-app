//
//  ApplicationViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class ApplicationViewModel {
    var applications: [JobApplicationEntity] = []
    var selectedStatus: JobStatusEnum = .applied
    var searchQuery: String = ""
    var isFilterPresented: Bool = false
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let getJobApplicationsUseCase: GetJobApplicationsUseCase
    private let saveJobApplicationUseCase: SaveJobApplicationUseCase
    private let deleteJobApplicationUseCase: DeleteJobApplicationUseCase
    private let updateJobStageUseCase: UpdateJobStageUseCase

    init(
        getJobApplicationsUseCase: GetJobApplicationsUseCase = GetJobApplicationsUseCase(repository: JobApplicationRepository()),
        saveJobApplicationUseCase: SaveJobApplicationUseCase = SaveJobApplicationUseCase(repository: JobApplicationRepository()),
        deleteJobApplicationUseCase: DeleteJobApplicationUseCase = DeleteJobApplicationUseCase(repository: JobApplicationRepository()),
        updateJobStageUseCase: UpdateJobStageUseCase = UpdateJobStageUseCase(repository: JobApplicationRepository())
    ) {
        self.getJobApplicationsUseCase = getJobApplicationsUseCase
        self.saveJobApplicationUseCase = saveJobApplicationUseCase
        self.deleteJobApplicationUseCase = deleteJobApplicationUseCase
        self.updateJobStageUseCase = updateJobStageUseCase
    }

    @MainActor
    func fetchApplications() async {
        isLoading = true
        errorMessage = nil
        do {
            applications = try await getJobApplicationsUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func filteredApplications(for status: JobStatusEnum) -> [JobApplicationEntity] {
        let statusFiltered = applications.filter { $0.status == status }
        guard !searchQuery.isEmpty else { return statusFiltered }
        return statusFiltered.filter {
            $0.position.localizedCaseInsensitiveContains(searchQuery) ||
            $0.company.localizedCaseInsensitiveContains(searchQuery)
        }
    }

    @MainActor
    func deleteApplication(id: UUID) async {
        do {
            try await deleteJobApplicationUseCase.execute(id)
            applications.removeAll { $0.id == id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    @MainActor
    func advanceStage(for application: JobApplicationEntity) async {
        let statuses: [JobStatusEnum] = [.needToApply, .applied, .assessment, .interview, .postInterview]
        if let currentIndex = statuses.firstIndex(of: application.status), currentIndex < statuses.count - 1 {
            let nextIndex = currentIndex + 1
            do {
                try await updateJobStageUseCase.execute(applicationId: application.id, newIndex: nextIndex)
                if let index = applications.firstIndex(where: { $0.id == application.id }) {
                    applications[index].status = statuses[nextIndex]
                }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
