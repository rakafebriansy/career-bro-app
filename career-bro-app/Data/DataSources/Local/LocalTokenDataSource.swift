//
//  LocalTokenDataSource.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

protocol LocalTokenDataSourceProtocol {
    func getTokenBalance() -> TokenBalanceEntity
    func deductTokens(count: Int) -> Bool
    func updateCustomApiKey(provider: String, key: String, isEnabled: Bool)
    func addTokens(count: Int)
}

final class LocalTokenDataSource: LocalTokenDataSourceProtocol {
    private let modelContext: ModelContext?
    private var inMemoryTokenBalance: TokenBalanceEntity
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
        self.inMemoryTokenBalance = TokenBalanceEntity(
            remainingTokens: 4250,
            totalQuota: 5000,
            isCustomKeyEnabled: false,
            customProvider: "OpenAI",
            customApiKey: "",
            transactions: [
                TokenTransactionEntity(title: "AI Chat Query", dateString: "Today, 10:45 AM", tokenDelta: -5, iconName: "bubble.left.and.bubble.right.fill"),
                TokenTransactionEntity(title: "CV Review Analysis", dateString: "Yesterday, 3:20 PM", tokenDelta: -25, iconName: "doc.text.magnifyingglass"),
                TokenTransactionEntity(title: "Daily Quota Reward", dateString: "Yesterday, 12:00 AM", tokenDelta: 500, iconName: "gift.fill"),
                TokenTransactionEntity(title: "Starter Package Top-Up", dateString: "Oct 10, 2026", tokenDelta: 2500, iconName: "bolt.badge.clock.fill")
            ]
        )
    }
    
    func getTokenBalance() -> TokenBalanceEntity {
        if let context = modelContext {
            let descriptor = FetchDescriptor<TokenBalanceModel>()
            if let model = try? context.fetch(descriptor).first {
                return TokenBalanceEntity(
                    remainingTokens: model.remainingTokens,
                    totalQuota: model.totalQuota,
                    isCustomKeyEnabled: model.isCustomKeyEnabled,
                    customProvider: model.customProvider,
                    customApiKey: model.customApiKey,
                    transactions: model.transactions.map {
                        TokenTransactionEntity(
                            id: $0.id,
                            title: $0.title,
                            dateString: $0.dateString,
                            tokenDelta: $0.tokenDelta,
                            iconName: $0.iconName,
                            timestamp: $0.timestamp
                        )
                    }
                )
            }
        }
        return inMemoryTokenBalance
    }
    
    func deductTokens(count: Int) -> Bool {
        if let context = modelContext {
            let descriptor = FetchDescriptor<TokenBalanceModel>()
            if let model = try? context.fetch(descriptor).first {
                guard model.remainingTokens >= count else { return false }
                model.remainingTokens -= count
                model.transactions.insert(
                    TokenTransactionItem(
                        title: "AI Query Usage",
                        dateString: "Just now",
                        tokenDelta: -count,
                        iconName: "sparkles"
                    ),
                    at: 0
                )
                try? context.save()
                return true
            }
        }
        guard inMemoryTokenBalance.remainingTokens >= count else { return false }
        inMemoryTokenBalance.remainingTokens -= count
        inMemoryTokenBalance.transactions.insert(
            TokenTransactionEntity(
                title: "AI Query Usage",
                dateString: "Just now",
                tokenDelta: -count,
                iconName: "sparkles"
            ),
            at: 0
        )
        return true
    }
    
    func updateCustomApiKey(provider: String, key: String, isEnabled: Bool) {
        if let context = modelContext {
            let descriptor = FetchDescriptor<TokenBalanceModel>()
            if let model = try? context.fetch(descriptor).first {
                model.customProvider = provider
                model.customApiKey = key
                model.isCustomKeyEnabled = isEnabled
                try? context.save()
            }
        }
        inMemoryTokenBalance.customProvider = provider
        inMemoryTokenBalance.customApiKey = key
        inMemoryTokenBalance.isCustomKeyEnabled = isEnabled
    }
    
    func addTokens(count: Int) {
        if let context = modelContext {
            let descriptor = FetchDescriptor<TokenBalanceModel>()
            if let model = try? context.fetch(descriptor).first {
                model.remainingTokens += count
                model.totalQuota += count
                model.transactions.insert(
                    TokenTransactionItem(
                        title: "Top-Up Tokens",
                        dateString: "Just now",
                        tokenDelta: count,
                        iconName: "bolt.fill"
                    ),
                    at: 0
                )
                try? context.save()
            }
        }
        inMemoryTokenBalance.remainingTokens += count
        inMemoryTokenBalance.totalQuota += count
        inMemoryTokenBalance.transactions.insert(
            TokenTransactionEntity(
                title: "Top-Up Tokens",
                dateString: "Just now",
                tokenDelta: count,
                iconName: "bolt.fill"
            ),
            at: 0
        )
    }
}
