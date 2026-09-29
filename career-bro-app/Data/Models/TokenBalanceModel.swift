//
//  TokenBalanceModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

struct TokenTransactionItem: Codable, Identifiable, Hashable {
    var id: UUID
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

@Model
final class TokenBalanceModel {
    @Attribute(.unique) var id: UUID
    var remainingTokens: Int
    var totalQuota: Int
    var isCustomKeyEnabled: Bool
    var customProvider: String
    var customApiKey: String
    var transactions: [TokenTransactionItem]

    init(
        id: UUID = UUID(),
        remainingTokens: Int = 4250,
        totalQuota: Int = 5000,
        isCustomKeyEnabled: Bool = false,
        customProvider: String = "OpenAI",
        customApiKey: String = "",
        transactions: [TokenTransactionItem] = [
            TokenTransactionItem(title: "AI Chat Query", dateString: "Today, 10:45 AM", tokenDelta: -5, iconName: "bubble.left.and.bubble.right.fill"),
            TokenTransactionItem(title: "CV Review Analysis", dateString: "Yesterday, 3:20 PM", tokenDelta: -25, iconName: "doc.text.magnifyingglass"),
            TokenTransactionItem(title: "Daily Quota Reward", dateString: "Yesterday, 12:00 AM", tokenDelta: 500, iconName: "gift.fill"),
            TokenTransactionItem(title: "Starter Package Top-Up", dateString: "Oct 10, 2026", tokenDelta: 2500, iconName: "bolt.badge.clock.fill")
        ]
    ) {
        self.id = id
        self.remainingTokens = remainingTokens
        self.totalQuota = totalQuota
        self.isCustomKeyEnabled = isCustomKeyEnabled
        self.customProvider = customProvider
        self.customApiKey = customApiKey
        self.transactions = transactions
    }
}
