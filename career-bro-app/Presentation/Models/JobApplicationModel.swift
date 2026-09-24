//
//  JobApplicationModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import Foundation
import SwiftData

/// Helper struct to encapsulate unified schedule and expiration UI states
struct JobDeadlineInfo {
    let stageLabel: String       // e.g., "Due Date", "Interview", "Announcement"
    let formattedDate: String    // e.g., "Oct 12, 2026 | 23.00"
    let relativeStatus: String   // e.g., "5 days left", "Today", "Expired"
    let isExpired: Bool
}

@Model
final class JobApplicationModel {
    @Attribute(.unique) var id: UUID
    
    // MARK: - Job Info
    var company: String
    var position: String
    var workLocation: WorkLocationTypeEnum
    var employment: EmploymentTypeEnum
    var priority: PriorityEnum
    var status: JobStatusEnum
    var salaryMin: Double?
    var salaryMax: Double?
    var currency: String = "IDR"
    
    // MARK: - Explicit Flow Timelines
    var createdAt: Date
    var updatedAt: Date
    var dueDate: Date?                   // Active during: .needToApply
    var announcementDate: Date?          // Active during: .applied
    var dateAssessment: Date?            // Active during: .assessment
    var dateInterview: Date?             // Active during: .interview
    var interviewAnnouncementDate: Date? // Active during: .postInterview
    
    // MARK: - Unified Computed Property (Upcoming + Expired)
    @Transient
    var deadlineInfo: JobDeadlineInfo? {
        let targetDate: Date?
        let label: String
        
        // 1. Determine the target calendar date based on the active status
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
            
        // 2. Final states DO NOT have a deadline or upcoming schedule
        case .accepted, .rejected, .ghosted, .offered:
            return nil
        }
        
        // Return nil if the user hasn't set a date for this specific stage yet
        guard let date = targetDate else { return nil }
        
        // 3. Calculate relative time status and expiration
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
    
    // MARK: - Initializer
    // Updated Initializer in JobApplicationModel.swift
    init(
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
        currency: String = "IDR"
    ) {
        self.id = UUID()
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
    }
}
