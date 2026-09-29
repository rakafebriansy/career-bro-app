//
//  HomeViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class HomeViewModel {
    var recentApplications: [JobApplicationEntity] = []
    var journeySummaries: [JourneySummaryEntity] = [JourneySummaryEntity()]
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let getJobApplicationsUseCase: GetJobApplicationsUseCase

    init(
        getJobApplicationsUseCase: GetJobApplicationsUseCase = GetJobApplicationsUseCase(
            repository: JobApplicationRepository()
        )
    ) {
        self.getJobApplicationsUseCase = getJobApplicationsUseCase
    }

    @MainActor
    func loadData() async {
        isLoading = true
        errorMessage = nil
        do {
            recentApplications = try await getJobApplicationsUseCase.execute()
            computeJourneySummary()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    private func computeJourneySummary() {
        let activeCount = recentApplications.filter { $0.status != .rejected && $0.status != .ghosted }.count
        let interviewCount = recentApplications.filter { $0.status == .interview || $0.status == .assessment || $0.status == .postInterview }.count
        let offerCount = recentApplications.filter { $0.status == .offered || $0.status == .accepted }.count
        let responseRate = recentApplications.isEmpty ? 0.0 : (Double(interviewCount + offerCount) / Double(recentApplications.count)) * 100.0

        journeySummaries = [
            JourneySummaryEntity(
                activeApplicationsCount: activeCount,
                interviewsScheduledCount: interviewCount,
                offersReceivedCount: offerCount,
                responseRate: responseRate
            )
        ]
    }
}
