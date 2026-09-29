//
//  CareerDNAViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class CareerDNAViewModel {
    var result: CareerAssessmentResultEntity?
    var isLoading: Bool = false
    var errorMessage: String? = nil

    private let getLatestResultUseCase: GetLatestCareerAssessmentResultUseCase

    init(
        getLatestResultUseCase: GetLatestCareerAssessmentResultUseCase = GetLatestCareerAssessmentResultUseCase(repository: CareerAssessmentRepository())
    ) {
        self.getLatestResultUseCase = getLatestResultUseCase
    }

    @MainActor
    func loadResult() async {
        isLoading = true
        errorMessage = nil
        do {
            result = try await getLatestResultUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
