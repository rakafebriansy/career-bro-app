//
//  AppNavigationRouter.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import Observation

@Observable
final class AppNavigationRouter {
    var selectedTab: Int = 0
    var activeJobDetailId: UUID? = nil
    var activeEmailDetailId: UUID? = nil
    var activeRoboPrompt: String? = nil
    var navigateToCareerAssessment: Bool = false
    var navigateToEmailCenter: Bool = false
    var navigateToManageToken: Bool = false
    var navigateToEditProfile: Bool = false
    var showResetDataConfirmation: Bool = false

    func openJobDetail(id: UUID) {
        selectedTab = 0
        activeJobDetailId = id
    }

    func openCareerAssessment() {
        selectedTab = 3
        navigateToCareerAssessment = true
    }

    func openEmailCenter(templateId: UUID? = nil) {
        selectedTab = 4
        activeEmailDetailId = templateId
        navigateToEmailCenter = true
    }

    func openEmailDetail(id: UUID) {
        openEmailCenter(templateId: id)
    }

    func openManageToken() {
        selectedTab = 4
        navigateToManageToken = true
    }

    func openEditProfile() {
        selectedTab = 4
        navigateToEditProfile = true
    }

    func openRoboChat(prompt: String? = nil) {
        selectedTab = 2
        activeRoboPrompt = prompt
    }

    func openResetDataConfirmation() {
        selectedTab = 4
        showResetDataConfirmation = true
    }

    func offAllNamed(to destination: SearchNavigationDestination) {
        activeJobDetailId = nil
        activeEmailDetailId = nil
        activeRoboPrompt = nil
        navigateToCareerAssessment = false
        navigateToEmailCenter = false
        navigateToManageToken = false
        navigateToEditProfile = false
        showResetDataConfirmation = false

        switch destination {
        case .tab(let index):
            selectedTab = index

        case .jobDetail(let id, _, _):
            openJobDetail(id: id)

        case .emailDetail(let id, _):
            openEmailDetail(id: id)

        case .salaryPredictor:
            selectedTab = 3

        case .cvReview:
            openRoboChat(prompt: "Tolong review dan evaluasi CV saya untuk format ATS.")

        case .careerAssessment:
            openCareerAssessment()

        case .careerDNA:
            selectedTab = 3

        case .roboChat(let initialPrompt):
            openRoboChat(prompt: initialPrompt)

        case .tokenHistory, .upgradePlan:
            openManageToken()

        case .profile:
            selectedTab = 4

        case .editProfile:
            openEditProfile()

        case .resetData:
            openResetDataConfirmation()
        }
    }
}
