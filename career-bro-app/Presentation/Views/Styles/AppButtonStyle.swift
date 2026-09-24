//
//  AppButtonStyle.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 19/07/26.
//

import Foundation
import SwiftUI

struct AppButtonStyle: ButtonStyle {
    var variant: ButtonVariant = .primary
    
    func makeBody(configuration: Configuration) -> some View {
            HStack {
                Image(systemName: "arrow.right")
                    .font(.footnote)
                    .foregroundStyle(.baseWhite)
                configuration.label
                    .foregroundStyle(.baseWhite)
                    .fontWeight(.medium)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.bgPrimary)
            .clipShape(
                RoundedRectangle(cornerRadius: 99)
            )
    }
}
