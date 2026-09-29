//
//  CareerDNAHistoryItemView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerDNAHistoryItemView: View {
    let title: String
    var date: String = "Oct 12, 2026"
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.bgPrimary)

                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .font(.caption)
                            .foregroundStyle(Color(hex: "#8E8E93"))

                        Text(date)
                            .font(.caption)
                            .foregroundStyle(Color(hex: "#8E8E93"))
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.subheadline)
                    .foregroundStyle(Color(hex: "#8E8E93"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack {
        CareerDNAHistoryItemView(title: "Art - Tech")
        CareerDNAHistoryItemView(title: "Analyst - Finance")
        CareerDNAHistoryItemView(title: "Medical")
    }
    .padding()
}
