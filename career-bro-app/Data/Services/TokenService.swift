//
//  TokenService.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

protocol TokenServiceProtocol {
    func validateSufficientTokens(available: Int, cost: Int) -> Bool
    func calculateRemainingPercentage(remaining: Int, total: Int) -> Double
}

final class TokenService: TokenServiceProtocol {
    init() {}
    
    func validateSufficientTokens(available: Int, cost: Int) -> Bool {
        return available >= cost
    }
    
    func calculateRemainingPercentage(remaining: Int, total: Int) -> Double {
        guard total > 0 else { return 0.0 }
        return Double(remaining) / Double(total)
    }
}
