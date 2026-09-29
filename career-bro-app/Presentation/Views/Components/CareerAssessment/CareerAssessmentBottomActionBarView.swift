//
//  CareerAssessmentBottomActionBarView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentBottomActionBarView: View {
    var showBackButton: Bool = true
    var backTitle: String = "Back"
    var nextTitle: String = "Next"
    var nextIcon: String = "arrow.right"
    var isNextDisabled: Bool = false
    var onBack: () -> Void
    var onNext: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            if showBackButton {
                Button {
                    onBack()
                } label: {
                    Text(backTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.bgPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 99))
                        .overlay(
                            RoundedRectangle(cornerRadius: 99)
                                .stroke(Color.bgPrimary, lineWidth: 1.5)
                        )
                }
                .buttonStyle(.plain)
            }

            Button {
                if !isNextDisabled {
                    onNext()
                }
            } label: {
                HStack(spacing: 6) {
                    Text(nextTitle)
                        .font(.subheadline)
                        .fontWeight(.medium)

                    Image(systemName: nextIcon)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color.baseWhite)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(isNextDisabled ? Color(hex: "#CCCCCC") : Color.bgPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 99))
            }
            .buttonStyle(.plain)
            .disabled(isNextDisabled)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        CareerAssessmentBottomActionBarView(
            showBackButton: false,
            nextTitle: "Next Stage",
            onBack: {},
            onNext: {}
        )
        CareerAssessmentBottomActionBarView(
            showBackButton: true,
            backTitle: "Previous",
            nextTitle: "Next Stage",
            onBack: {},
            onNext: {}
        )
    }
    .padding()
}
