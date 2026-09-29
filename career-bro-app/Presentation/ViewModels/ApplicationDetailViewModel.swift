//
//  ApplicationDetailViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class ApplicationDetailViewModel {
    var application: JobApplicationEntity
    var isEditingPresented: Bool = false
    var isDeleteAlertPresented: Bool = false
    var isSaved: Bool = false
    var errorMessage: String? = nil
    
    private let updateJobApplicationUseCase: UpdateJobApplicationUseCase
    private let deleteJobApplicationUseCase: DeleteJobApplicationUseCase
    private let updateJobStageUseCase: UpdateJobStageUseCase
    
    init(
        application: JobApplicationEntity,
        updateJobApplicationUseCase: UpdateJobApplicationUseCase = UpdateJobApplicationUseCase(repository: JobApplicationRepository()),
        deleteJobApplicationUseCase: DeleteJobApplicationUseCase = DeleteJobApplicationUseCase(repository: JobApplicationRepository()),
        updateJobStageUseCase: UpdateJobStageUseCase = UpdateJobStageUseCase(repository: JobApplicationRepository())
    ) {
        self.application = application
        self.updateJobApplicationUseCase = updateJobApplicationUseCase
        self.deleteJobApplicationUseCase = deleteJobApplicationUseCase
        self.updateJobStageUseCase = updateJobStageUseCase
    }
    
    @MainActor
    func updateStatus(_ newStatus: JobStatusEnum) async {
        application.status = newStatus
        application.updatedAt = Date()
        do {
            try await updateJobApplicationUseCase.execute(application)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func saveApplication() async {
        do {
            try await updateJobApplicationUseCase.execute(application)
            isSaved = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func deleteApplication() async {
        do {
            try await deleteJobApplicationUseCase.execute(application.id)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
