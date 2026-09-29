//
//  ProfileEditFormFieldView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct ProfileEditFormFieldView: View {
    let title: String
    @Binding var text: String
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType? = nil
    var autocapitalization: TextInputAutocapitalization = .never

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.black)

            TextField(placeholder, text: $text)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.black)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .textInputAutocapitalization(autocapitalization)
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
        }
    }
}

#Preview {
    ProfileEditFormFieldView(
        title: "Name",
        text: .constant("Raka Febrian"),
        placeholder: "Enter full name"
    )
    .padding()
}
