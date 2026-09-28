//
//  TokenTopUpPackagesView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct TokenTopUpPackagesView: View {
    struct TokenPackage: Identifiable {
        let id: String
        let title: String
        let tokenCount: Int
        let priceString: String
        let description: String
        let badge: String?
        let isHighlighted: Bool
    }
    
    var packages: [TokenPackage] = [
        TokenPackage(
            id: "starter_1k",
            title: "Starter Pack",
            tokenCount: 1000,
            priceString: "Rp 19.000",
            description: "Good for ~50 AI chat responses",
            badge: nil,
            isHighlighted: false
        ),
        TokenPackage(
            id: "pro_5k",
            title: "Professional Pack",
            tokenCount: 5000,
            priceString: "Rp 69.000",
            description: "Best for active job applications",
            badge: "POPULAR",
            isHighlighted: true
        ),
        TokenPackage(
            id: "ultimate_15k",
            title: "Ultimate Pack",
            tokenCount: 15000,
            priceString: "Rp 149.000",
            description: "Unlimited power for multi-role search",
            badge: "BEST VALUE",
            isHighlighted: false
        )
    ]
    
    var onSelectPackage: ((TokenPackage) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Top Up Packages")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            VStack(spacing: 12) {
                ForEach(packages) { package in
                    packageCard(package: package)
                }
            }
        }
    }
    
    private func packageCard(package: TokenPackage) -> some View {
        Button {
            onSelectPackage?(package)
        } label: {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(package.isHighlighted ? Color.bgPrimary.opacity(0.12) : Color(hex: "#F1F5F9"))
                        .frame(width: 46, height: 46)
                    
                    Image(systemName: "sparkle")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(package.isHighlighted ? Color.bgPrimary : Color(hex: "#4B5563"))
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Text(package.title)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)
                        
                        if let badge = package.badge {
                            Text(badge)
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(Color.bgPrimary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color(hex: "#EFF6FF"))
                                .clipShape(Capsule())
                        }
                    }
                    
                    Text("\(package.tokenCount) Tokens • \(package.description)")
                        .font(.caption2)
                        .foregroundStyle(Color(hex: "#737373"))
                }
                
                Spacer()
                
                Text(package.priceString)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(package.isHighlighted ? Color.white : .textPrimary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(package.isHighlighted ? Color.bgPrimary : Color(hex: "#F1F5F9"))
                    .clipShape(Capsule())
            }
            .padding(14)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(package.isHighlighted ? Color.bgPrimary : Color.baseStroke, lineWidth: package.isHighlighted ? 1.5 : 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TokenTopUpPackagesView()
        .padding()
}
