//
//  JourneySummaryEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct JourneySummaryEntity: Identifiable, Equatable {
    let id: UUID
    var activeApplicationsCount: Int
    var interviewsScheduledCount: Int
    var offersReceivedCount: Int
    var responseRate: Double
    
    init(
        id: UUID = UUID(),
        activeApplicationsCount: Int = 12,
        interviewsScheduledCount: Int = 4,
        offersReceivedCount: Int = 1,
        responseRate: Double = 33.3
    ) {
        self.id = id
        self.activeApplicationsCount = activeApplicationsCount
        self.interviewsScheduledCount = interviewsScheduledCount
        self.offersReceivedCount = offersReceivedCount
        self.responseRate = responseRate
    }
}
