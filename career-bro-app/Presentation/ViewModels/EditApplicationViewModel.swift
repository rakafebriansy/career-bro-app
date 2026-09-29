//
//  EditApplicationViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class EditApplicationViewModel {
    var id: UUID
    var company: String
    var position: String
    var status: JobStatusEnum
    var workLocation: WorkLocationTypeEnum
    var employment: EmploymentTypeEnum
    var priority: PriorityEnum
    var location: String
    var salaryMin: Double?
    var salaryMax: Double?
    var currency: String
    var dueDate: Date?
    var announcementDate: Date?
    var dateAssessment: Date?
    var dateInterview: Date?
    var interviewAnnouncementDate: Date?
    var jobDescription: String
    var requirements: [String]
    var keywords: [String]
    var aiSuggestion: String?
    var jobUrl: String
    var attachments: [String]
    var isSuccess: Bool = false
    var errorMessage: String? = nil

    private let updateJobApplicationUseCase: UpdateJobApplicationUseCase

    init(
        application: JobApplicationEntity,
        updateJobApplicationUseCase: UpdateJobApplicationUseCase = UpdateJobApplicationUseCase(repository: JobApplicationRepository())
    ) {
        self.id = application.id
        self.company = application.company
        self.position = application.position
        self.status = application.status
        self.workLocation = application.workLocation
        self.employment = application.employment
        self.priority = application.priority
        self.location = application.location ?? ""
        self.salaryMin = application.salaryMin
        self.salaryMax = application.salaryMax
        self.currency = application.currency
        self.dueDate = application.dueDate
        self.announcementDate = application.announcementDate
        self.dateAssessment = application.dateAssessment
        self.dateInterview = application.dateInterview
        self.interviewAnnouncementDate = application.interviewAnnouncementDate
        self.jobDescription = application.jobDescription ?? ""
        self.requirements = application.requirements ?? []
        self.keywords = application.keywords ?? []
        self.aiSuggestion = application.aiSuggestion
        self.jobUrl = application.jobUrl ?? ""
        self.attachments = application.attachments ?? []
        self.updateJobApplicationUseCase = updateJobApplicationUseCase
    }

    @MainActor
    func saveChanges() async {
        let updated = JobApplicationEntity(
            id: id,
            company: company,
            position: position,
            status: status,
            workLocation: workLocation,
            employment: employment,
            priority: priority,
            updatedAt: Date(),
            dueDate: dueDate,
            announcementDate: announcementDate,
            dateAssessment: dateAssessment,
            dateInterview: dateInterview,
            interviewAnnouncementDate: interviewAnnouncementDate,
            salaryMin: salaryMin,
            salaryMax: salaryMax,
            currency: currency,
            location: location.isEmpty ? nil : location,
            jobDescription: jobDescription.isEmpty ? nil : jobDescription,
            requirements: requirements.isEmpty ? nil : requirements,
            keywords: keywords.isEmpty ? nil : keywords,
            aiSuggestion: aiSuggestion,
            jobUrl: jobUrl.isEmpty ? nil : jobUrl,
            attachments: attachments.isEmpty ? nil : attachments
        )
        do {
            try await updateJobApplicationUseCase.execute(updated)
            isSuccess = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
