//
//  RoboChatTopBarView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct RoboChatTopBarView: View {
    var tokensUsed: Int = 5
    var totalTokens: Int = 25
    var onMenuTap: (() -> Void)? = nil
    var onTokenTap: (() -> Void)? = nil

    private var progress: Double {
        guard totalTokens > 0 else { return 0 }
        return Double(tokensUsed) / Double(totalTokens)
    }

    var body: some View {
        HStack {
            Button {
                onMenuTap?()
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 16, weight: .semibold))
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

            HStack(spacing: 8) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.bgPrimary)
                        .frame(width: 32, height: 32)

                    Image(systemName: "person.crop.square.fill.and.at.rectangle")
                        .symbolRenderingMode(.hierarchical)
                        .font(.system(size: 18))
                        .foregroundStyle(.white)
                }

                Text("Robo")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.bgPrimary)
            }

            Spacer()

            Button {
                onTokenTap?()
            } label: {
                HStack(spacing: 6) {
                    ZStack {
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 2.5)
                            .frame(width: 18, height: 18)

                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                            .stroke(
                                Color.bgPrimary,
                                style: StrokeStyle(lineWidth: 2.5, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: 18, height: 18)
                    }

                    Text("\(tokensUsed)/\(totalTokens)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color(hex: "4B5563"))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }
}

#Preview {
    RoboChatTopBarView()
}
