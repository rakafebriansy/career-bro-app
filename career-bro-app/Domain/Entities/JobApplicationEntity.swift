//
//  JobApplicationEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct JobApplicationEntity: Identifiable, Equatable {
    let id: UUID
    var company: String
    var position: String
    var status: JobStatusEnum
    var workLocation: WorkLocationTypeEnum
    var employment: EmploymentTypeEnum
    var priority: PriorityEnum
    var createdAt: Date
    var updatedAt: Date
    var dueDate: Date?
    var announcementDate: Date?
    var dateAssessment: Date?
    var dateInterview: Date?
    var interviewAnnouncementDate: Date?
    var salaryMin: Double?
    var salaryMax: Double?
    var currency: String
    var location: String?
    var jobDescription: String?
    var requirements: [String]?
    var keywords: [String]?
    var aiSuggestion: String?
    var jobUrl: String?
    var attachments: [String]?
    
    init(
        id: UUID = UUID(),
        company: String,
        position: String,
        status: JobStatusEnum = .applied,
        workLocation: WorkLocationTypeEnum = .remote,
        employment: EmploymentTypeEnum = .fullTime,
        priority: PriorityEnum = .medium,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        dueDate: Date? = nil,
        announcementDate: Date? = nil,
        dateAssessment: Date? = nil,
        dateInterview: Date? = nil,
        interviewAnnouncementDate: Date? = nil,
        salaryMin: Double? = nil,
        salaryMax: Double? = nil,
        currency: String = "IDR",
        location: String? = nil,
        jobDescription: String? = nil,
        requirements: [String]? = nil,
        keywords: [String]? = nil,
        aiSuggestion: String? = nil,
        jobUrl: String? = nil,
        attachments: [String]? = nil
    ) {
        self.id = id
        self.company = company
        self.position = position
        self.status = status
        self.workLocation = workLocation
        self.employment = employment
        self.priority = priority
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.dueDate = dueDate
        self.announcementDate = announcementDate
        self.dateAssessment = dateAssessment
        self.dateInterview = dateInterview
        self.interviewAnnouncementDate = interviewAnnouncementDate
        self.salaryMin = salaryMin
        self.salaryMax = salaryMax
        self.currency = currency
        self.location = location
        self.jobDescription = jobDescription
        self.requirements = requirements
        self.keywords = keywords
        self.aiSuggestion = aiSuggestion
        self.jobUrl = jobUrl
        self.attachments = attachments
    }
}
