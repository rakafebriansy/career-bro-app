//
//  JobApplicationRepository.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol JobApplicationRepositoryProtocol {
    func getApplications() async throws -> [JobApplicationEntity]
    func getApplicationById(_ id: UUID) async throws -> JobApplicationEntity?
    func saveApplication(_ application: JobApplicationEntity) async throws
    func updateApplication(_ application: JobApplicationEntity) async throws
    func deleteApplication(_ id: UUID) async throws
    func updateStageIndex(for applicationId: UUID, newIndex: Int) async throws
}

final class JobApplicationRepository: JobApplicationRepositoryProtocol {
    private let dataSource: LocalJobDataSourceProtocol

    init(dataSource: LocalJobDataSourceProtocol = LocalJobDataSource()) {
        self.dataSource = dataSource
    }

    func getApplications() async throws -> [JobApplicationEntity] {
        let models = try dataSource.fetchApplications()
        return models.map { mapToEntity($0) }
    }

    func getApplicationById(_ id: UUID) async throws -> JobApplicationEntity? {
        guard let model = try dataSource.fetchApplication(byId: id) else { return nil }
        return mapToEntity(model)
    }

    func saveApplication(_ application: JobApplicationEntity) async throws {
        let model = mapToModel(application)
        try dataSource.insertApplication(model)
    }

    func updateApplication(_ application: JobApplicationEntity) async throws {
        if let existing = try dataSource.fetchApplication(byId: application.id) {
            existing.company = application.company
            existing.position = application.position
            existing.status = application.status
            existing.workLocation = application.workLocation
            existing.employment = application.employment
            existing.priority = application.priority
            existing.updatedAt = Date()
            existing.dueDate = application.dueDate
            existing.announcementDate = application.announcementDate
            existing.dateAssessment = application.dateAssessment
            existing.dateInterview = application.dateInterview
            existing.interviewAnnouncementDate = application.interviewAnnouncementDate
            existing.salaryMin = application.salaryMin
            existing.salaryMax = application.salaryMax
            existing.currency = application.currency
            existing.location = application.location
            existing.jobDescription = application.jobDescription
            existing.requirements = application.requirements
            existing.keywords = application.keywords
            existing.aiSuggestion = application.aiSuggestion
            existing.jobUrl = application.jobUrl
            existing.attachments = application.attachments
            try dataSource.save()
        }
    }

    func deleteApplication(_ id: UUID) async throws {
        if let existing = try dataSource.fetchApplication(byId: id) {
            try dataSource.deleteApplication(existing)
        }
    }

    func updateStageIndex(for applicationId: UUID, newIndex: Int) async throws {
        if let existing = try dataSource.fetchApplication(byId: applicationId) {
            let statuses: [JobStatusEnum] = [.needToApply, .applied, .assessment, .interview, .postInterview]
            if newIndex >= 0 && newIndex < statuses.count {
                existing.status = statuses[newIndex]
                existing.updatedAt = Date()
                try dataSource.save()
            }
        }
    }

    private func mapToEntity(_ model: JobApplicationModel) -> JobApplicationEntity {
        JobApplicationEntity(
            id: model.id,
            company: model.company,
            position: model.position,
            status: model.status,
            workLocation: model.workLocation,
            employment: model.employment,
            priority: model.priority,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt,
            dueDate: model.dueDate,
            announcementDate: model.announcementDate,
            dateAssessment: model.dateAssessment,
            dateInterview: model.dateInterview,
            interviewAnnouncementDate: model.interviewAnnouncementDate,
            salaryMin: model.salaryMin,
            salaryMax: model.salaryMax,
            currency: model.currency,
            location: model.location,
            jobDescription: model.jobDescription,
            requirements: model.requirements,
            keywords: model.keywords,
            aiSuggestion: model.aiSuggestion,
            jobUrl: model.jobUrl,
            attachments: model.attachments
        )
    }

    private func mapToModel(_ entity: JobApplicationEntity) -> JobApplicationModel {
        JobApplicationModel(
            id: entity.id,
            company: entity.company,
            position: entity.position,
            status: entity.status,
            workLocation: entity.workLocation,
            employment: entity.employment,
            priority: entity.priority,
            createdAt: entity.createdAt,
            updatedAt: entity.updatedAt,
            dueDate: entity.dueDate,
            announcementDate: entity.announcementDate,
            dateAssessment: entity.dateAssessment,
            dateInterview: entity.dateInterview,
            interviewAnnouncementDate: entity.interviewAnnouncementDate,
            salaryMin: entity.salaryMin,
            salaryMax: entity.salaryMax,
            currency: entity.currency,
            location: entity.location,
            jobDescription: entity.jobDescription,
            requirements: entity.requirements,
            keywords: entity.keywords,
            aiSuggestion: entity.aiSuggestion,
            jobUrl: entity.jobUrl,
            attachments: entity.attachments
        )
    }
}
