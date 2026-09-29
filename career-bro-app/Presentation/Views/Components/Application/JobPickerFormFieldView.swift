//
//  JobPickerFormFieldView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct JobPickerFormFieldView<T: Hashable & RawRepresentable>: View where T.RawValue == String {
    let title: String
    let options: [T]
    @Binding var selection: T

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.black)

            Menu {
                ForEach(options, id: \.self) { option in
                    Button {
                        selection = option
                    } label: {
                        HStack {
                            Text(option.rawValue)
                            if selection == option {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selection.rawValue)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(Color(hex: "1F2937"))

                    Spacer()

                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.secondary)
                }
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
}
