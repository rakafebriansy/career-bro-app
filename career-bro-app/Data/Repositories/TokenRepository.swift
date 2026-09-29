//
//  TokenRepository.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol TokenRepositoryProtocol {
    func getTokenBalance() async throws -> TokenBalanceEntity
    func consumeToken(count: Int) async throws -> Bool
    func saveCustomApiKey(provider: String, key: String, isEnabled: Bool) async throws
    func topUpTokens(count: Int) async throws
}

final class TokenRepository: TokenRepositoryProtocol {
    private let dataSource: LocalTokenDataSourceProtocol
    
    init(dataSource: LocalTokenDataSourceProtocol = LocalTokenDataSource()) {
        self.dataSource = dataSource
    }
    
    func getTokenBalance() async throws -> TokenBalanceEntity {
        return dataSource.getTokenBalance()
    }
    
    func consumeToken(count: Int) async throws -> Bool {
        return dataSource.deductTokens(count: count)
    }
    
    func saveCustomApiKey(provider: String, key: String, isEnabled: Bool) async throws {
        dataSource.updateCustomApiKey(provider: provider, key: key, isEnabled: isEnabled)
    }
    
    func topUpTokens(count: Int) async throws {
        dataSource.addTokens(count: count)
    }
}
