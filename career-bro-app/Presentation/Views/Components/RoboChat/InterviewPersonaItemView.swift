//
//  InterviewPersonaItemView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct InterviewPersonaItemView: View {
    let persona: InterviewerPersonaModel
    let isSelected: Bool
    var onSelect: (() -> Void)? = nil

    var body: some View {
        Button {
            onSelect?()
        } label: {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color(hex: persona.bgColorHex))
                        .frame(width: 72, height: 72)

                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 58, height: 58)
                        .foregroundStyle(Color(hex: "475569"))
                }
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.bgPrimary : Color.clear, lineWidth: 2)
                )

                Text(persona.name)
                    .font(.system(size: 13, weight: isSelected ? .semibold : .medium))
                    .foregroundStyle(isSelected ? Color.bgPrimary : Color(hex: "4B5563"))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 16) {
        InterviewPersonaItemView(
            persona: InterviewerPersonaModel.samplePersonas[0],
            isSelected: false
        )
        InterviewPersonaItemView(
            persona: InterviewerPersonaModel.samplePersonas[2],
            isSelected: true
        )
    }
    .padding()
}
