//
//  EmailTemplateRowView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct EmailTemplateRowView: View {
    let template: EmailTemplateModel
    var onSelect: (() -> Void)? = nil

    var body: some View {
        Button {
            onSelect?()
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(template.title)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.bgPrimary)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(template.tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(Color(hex: "#4B5563"))
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color(hex: "#F1F5F9"))
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "#9CA3AF"))
                }
                .padding(.vertical, 14)

                Divider()
                    .foregroundStyle(Color.baseStroke)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    EmailTemplateRowView(
        template: EmailTemplateModel.sampleTemplates[0]
    )
    .padding()
}
