//
//  JobFormFieldView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct JobFormFieldView: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.black)

            TextField(placeholder, text: $text)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color(hex: "1F2937"))
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
        }
    }
}
