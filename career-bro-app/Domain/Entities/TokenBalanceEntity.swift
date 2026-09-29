//
//  TokenBalanceEntity.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct TokenTransactionEntity: Identifiable, Equatable {
    let id: UUID
    var title: String
    var dateString: String
    var tokenDelta: Int
    var iconName: String
    var timestamp: Date
    
    init(
        id: UUID = UUID(),
        title: String,
        dateString: String,
        tokenDelta: Int,
        iconName: String,
        timestamp: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.dateString = dateString
        self.tokenDelta = tokenDelta
        self.iconName = iconName
        self.timestamp = timestamp
    }
}

struct TokenBalanceEntity: Equatable {
    var remainingTokens: Int
    var totalQuota: Int
    var isCustomKeyEnabled: Bool
    var customProvider: String
    var customApiKey: String
    var transactions: [TokenTransactionEntity]
    
    init(
        remainingTokens: Int = 4250,
        totalQuota: Int = 5000,
        isCustomKeyEnabled: Bool = false,
        customProvider: String = "OpenAI",
        customApiKey: String = "",
        transactions: [TokenTransactionEntity] = []
    ) {
        self.remainingTokens = remainingTokens
        self.totalQuota = totalQuota
        self.isCustomKeyEnabled = isCustomKeyEnabled
        self.customProvider = customProvider
        self.customApiKey = customApiKey
        self.transactions = transactions
    }
}
