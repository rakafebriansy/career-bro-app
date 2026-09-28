//
//  CareerAssessmentResultWorkPreferencesView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentResultWorkPreferencesView: View {
    struct RecommendationItem: Identifiable {
        let id = UUID()
        let title: String
        let fitPercentage: Int
    }
    
    var preferences: [(icon: String, text: String)] = [
        ("laptopcomputer", "Hybrid"),
        ("briefcase", "Creative, Tech"),
        ("clock.arrow.2.circlepath", "Iterative Work")
    ]
    
    var recommendations: [RecommendationItem] = [
        RecommendationItem(title: "System Analyst", fitPercentage: 96),
        RecommendationItem(title: "System Analyst", fitPercentage: 88),
        RecommendationItem(title: "System Analyst", fitPercentage: 78)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Work Preferences & Recomendations")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(preferences, id: \.text) { item in
                    HStack(spacing: 12) {
                        Image(systemName: item.icon)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.bgPrimary)
                            .frame(width: 22, alignment: .center)
                        
                        Text(item.text)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.textPrimary)
                    }
                }
            }
            .padding(.bottom, 4)
            
            VStack(spacing: 10) {
                ForEach(recommendations) { item in
                    recommendationCard(item: item)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func recommendationCard(item: RecommendationItem) -> some View {
        HStack {
            Text(item.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.textPrimary)
            
            Spacer()
            
            Text("\(item.fitPercentage)% fit")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.bgPrimary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color(hex: "#EFF6FF"))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.baseStroke, lineWidth: 1)
        )
    }
}

#Preview {
    CareerAssessmentResultWorkPreferencesView()
        .padding()
}
