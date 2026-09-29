//
//  ManageTokenViewModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class ManageTokenViewModel {
    var tokenBalance: TokenBalanceEntity = TokenBalanceEntity()
    var isCustomKeyEnabled: Bool = false
    var selectedProvider: String = "OpenAI"
    var apiKey: String = ""
    var isTopUpSuccessAlertPresented: Bool = false
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let getTokenBalanceUseCase: GetTokenBalanceUseCase
    private let saveCustomApiKeyUseCase: SaveCustomApiKeyUseCase
    private let topUpTokensUseCase: TopUpTokensUseCase
    
    init(
        getTokenBalanceUseCase: GetTokenBalanceUseCase = GetTokenBalanceUseCase(repository: TokenRepository()),
        saveCustomApiKeyUseCase: SaveCustomApiKeyUseCase = SaveCustomApiKeyUseCase(repository: TokenRepository()),
        topUpTokensUseCase: TopUpTokensUseCase = TopUpTokensUseCase(repository: TokenRepository())
    ) {
        self.getTokenBalanceUseCase = getTokenBalanceUseCase
        self.saveCustomApiKeyUseCase = saveCustomApiKeyUseCase
        self.topUpTokensUseCase = topUpTokensUseCase
    }
    
    @MainActor
    func loadTokenBalance() async {
        isLoading = true
        errorMessage = nil
        do {
            tokenBalance = try await getTokenBalanceUseCase.execute()
            isCustomKeyEnabled = tokenBalance.isCustomKeyEnabled
            selectedProvider = tokenBalance.customProvider
            apiKey = tokenBalance.customApiKey
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    @MainActor
    func saveApiKey(provider: String, key: String) async {
        do {
            try await saveCustomApiKeyUseCase.execute(provider: provider, key: key, isEnabled: isCustomKeyEnabled)
            tokenBalance.customProvider = provider
            tokenBalance.customApiKey = key
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    @MainActor
    func topUp(count: Int) async {
        do {
            try await topUpTokensUseCase.execute(count: count)
            tokenBalance.remainingTokens += count
            tokenBalance.totalQuota += count
            isTopUpSuccessAlertPresented = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
