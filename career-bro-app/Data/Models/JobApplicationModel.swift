//
//  JobApplicationModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

struct JobDeadlineInfo {
    let stageLabel: String
    let formattedDate: String
    let relativeStatus: String
    let isExpired: Bool
}

@Model
final class JobApplicationModel {
    @Attribute(.unique) var id: UUID

    var company: String
    var position: String
    var workLocation: WorkLocationTypeEnum
    var employment: EmploymentTypeEnum
    var priority: PriorityEnum
    var status: JobStatusEnum
    var location: String?
    var salaryMin: Double?
    var salaryMax: Double?
    var currency: String = "IDR"
    var jobDescription: String?
    var requirements: [String]?
    var keywords: [String]?
    var aiSuggestion: String?
    var jobUrl: String?
    var attachments: [String]?

    var createdAt: Date
    var updatedAt: Date
    var dueDate: Date?
    var announcementDate: Date?
    var dateAssessment: Date?
    var dateInterview: Date?
    var interviewAnnouncementDate: Date?

    @Transient
    var deadlineInfo: JobDeadlineInfo? {
        let targetDate: Date?
        let label: String

        switch status {
        case .needToApply:
            targetDate = dueDate
            label = "Due Date"
        case .applied:
            targetDate = announcementDate
            label = "Announcement"
        case .assessment:
            targetDate = dateAssessment
            label = "Assessment Date"
        case .interview:
            targetDate = dateInterview
            label = "Interview"
        case .postInterview:
            targetDate = interviewAnnouncementDate
            label = "Announcement"

        case .accepted, .rejected, .ghosted, .offered:
            return nil
        }

        guard let date = targetDate else { return nil }

        let now = Date()
        let calendar = Calendar.current
        let isPast = date < now

        let components = calendar.dateComponents([.day], from: now, to: date)
        let daysLeft = components.day ?? 0

        let relativeStr: String
        if isPast {
            relativeStr = "Expired"
        } else if calendar.isDateInToday(date) {
            relativeStr = "Today"
        } else if calendar.isDateInTomorrow(date) {
            relativeStr = "Tomorrow"
        } else {
            relativeStr = "\(daysLeft) days left"
        }

        return JobDeadlineInfo(
            stageLabel: label,
            formattedDate: date.toFormattedDatetime(),
            relativeStatus: relativeStr,
            isExpired: isPast
        )
    }

    init(
        id: UUID = UUID(),
        company: String,
        position: String,
        status: JobStatusEnum,
        workLocation: WorkLocationTypeEnum,
        employment: EmploymentTypeEnum,
        priority: PriorityEnum,
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
        self.workLocation = workLocation
        self.status = status
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
