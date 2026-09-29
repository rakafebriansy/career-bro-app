//
//  CareerDNAHeroCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerDNAHeroCardView: View {
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Discover Your Career DNA")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.baseWhite)

                    Text("An AI powered assesment that maps who you are to where you're meant to go")
                        .font(.caption)
                        .foregroundStyle(.baseWhite.opacity(0.85))
                        .lineSpacing(2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer(minLength: 60)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)

            Image(systemName: "suitcase.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.baseWhite.opacity(0.18))
                .padding(.trailing, 16)
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [.bgPrimary, .bgDarkPrimary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CareerDNAHeroCardView()
        .padding()
}
