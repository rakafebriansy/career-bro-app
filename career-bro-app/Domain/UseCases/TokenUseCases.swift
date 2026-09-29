//
//  TokenUseCases.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct GetTokenBalanceUseCase {
    private let repository: TokenRepositoryProtocol

    init(repository: TokenRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> TokenBalanceEntity {
        try await repository.getTokenBalance()
    }
}

struct ConsumeTokenUseCase {
    private let repository: TokenRepositoryProtocol

    init(repository: TokenRepositoryProtocol) {
        self.repository = repository
    }

    func execute(count: Int = 1) async throws -> Bool {
        try await repository.consumeToken(count: count)
    }
}

struct SaveCustomApiKeyUseCase {
    private let repository: TokenRepositoryProtocol

    init(repository: TokenRepositoryProtocol) {
        self.repository = repository
    }

    func execute(provider: String, key: String, isEnabled: Bool) async throws {
        try await repository.saveCustomApiKey(provider: provider, key: key, isEnabled: isEnabled)
    }
}

struct TopUpTokensUseCase {
    private let repository: TokenRepositoryProtocol

    init(repository: TokenRepositoryProtocol) {
        self.repository = repository
    }

    func execute(count: Int) async throws {
        try await repository.topUpTokens(count: count)
    }
}
