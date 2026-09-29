//
//  ManageTokenView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct ManageTokenView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var remainingTokens: Int = 4250
    @State private var totalQuota: Int = 5000
    @State private var isCustomKeyEnabled: Bool = false
    @State private var selectedProvider: String = "OpenAI"
    @State private var apiKey: String = ""
    @State private var showPurchaseAlert: Bool = false
    @State private var purchasedPackageName: String = ""
    @State private var showDailyBonusAlert: Bool = false
    @State private var isDailyBonusClaimed: Bool = false
    @State private var showInfoSheet: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    TokenBalanceHeroCardView(
                        remainingTokens: remainingTokens,
                        totalQuota: totalQuota,
                        onClaimDaily: {
                            if !isDailyBonusClaimed {
                                remainingTokens += 100
                                isDailyBonusClaimed = true
                                showDailyBonusAlert = true
                            }
                        },
                        onTopUp: {
                            purchasedPackageName = "Professional Pack (5,000 Tokens)"
                            showPurchaseAlert = true
                        }
                    )

                    TokenUsageBreakdownView()

                    TokenCustomApiKeyCardView(
                        isCustomKeyEnabled: $isCustomKeyEnabled,
                        selectedProvider: $selectedProvider,
                        apiKey: $apiKey,
                        onSaveKey: { provider, key in
                        }
                    )

                    TokenTopUpPackagesView { package in
                        purchasedPackageName = "\(package.title) (\(package.tokenCount) Tokens)"
                        showPurchaseAlert = true
                    }

                    TokenTransactionHistoryView()
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 36)
            }
            .background(Color(hex: "#F8FAFC"))
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .alert("Daily Bonus Claimed!", isPresented: $showDailyBonusAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You have received +100 free AI tokens. Come back tomorrow for more!")
        }
        .alert("Top Up Confirmation", isPresented: $showPurchaseAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Confirm Purchase") {
                if purchasedPackageName.contains("1,000") {
                    remainingTokens += 1000
                } else if purchasedPackageName.contains("5,000") {
                    remainingTokens += 5000
                } else if purchasedPackageName.contains("15,000") {
                    remainingTokens += 15000
                } else {
                    remainingTokens += 1000
                }
            }
        } message: {
            Text("Would you like to purchase \(purchasedPackageName)?")
        }
        .sheet(isPresented: $showInfoSheet) {
            tokenInfoModalView
        }
    }

    private var topNavigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.baseText)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)

            Spacer()

            Text("Manage Token")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            Spacer()

            Button {
                showInfoSheet = true
            } label: {
                Image(systemName: "info.circle")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.baseText)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }

    private var tokenInfoModalView: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("How AI Tokens Work")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.textPrimary)

                    Text("AI Tokens are credits used when generating cover letters, scanning resumes, and interacting with the AI Career Companion.")
                        .font(.subheadline)
                        .foregroundStyle(Color(hex: "#4B5563"))
                        .lineSpacing(3)
                }

                VStack(alignment: .leading, spacing: 14) {
                    infoRow(icon: "sparkles", title: "Chatbot Queries", desc: "15-25 tokens per conversation turn")
                    infoRow(icon: "doc.text.magnifyingglass", title: "Resume AI Review", desc: "50 tokens per document scan")
                    infoRow(icon: "envelope.badge.shield.half.filled", title: "Cover Letter Drafting", desc: "50 tokens per personalized letter")
                    infoRow(icon: "key.fill", title: "Custom API Key", desc: "Zero token cost when using your own key")
                }
                .padding(16)
                .background(Color(hex: "#F8FAFC"))
                .clipShape(RoundedRectangle(cornerRadius: 14))

                Spacer()
            }
            .padding(20)
            .navigationTitle("About AI Tokens")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        showInfoSheet = false
                    }
                    .fontWeight(.bold)
                }
            }
        }
        .presentationDetents([.medium])
    }

    private func infoRow(icon: String, title: String, desc: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.bgPrimary)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textPrimary)

                Text(desc)
                    .font(.caption)
                    .foregroundStyle(Color(hex: "#737373"))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ManageTokenView()
    }
}
