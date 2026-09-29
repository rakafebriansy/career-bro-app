//
//  CreateEmailTemplateSheetView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CreateEmailTemplateSheetView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var templateTitle: String = ""
    @State private var rawTags: String = ""
    @State private var subjectLine: String = ""
    @State private var bodyContent: String = ""

    var onSave: ((EmailTemplateModel) -> Void)? = nil

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Template Title")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)

                        TextField("e.g. Template Follow-Up", text: $templateTitle)
                            .font(.system(size: 14))
                            .padding(12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.baseStroke, lineWidth: 1)
                            )
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Role Tags (comma-separated)")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)

                        TextField("e.g. Fullstack, Back-End, UI/UX", text: $rawTags)
                            .font(.system(size: 14))
                            .padding(12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.baseStroke, lineWidth: 1)
                            )
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email Subject")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)

                        TextField("e.g. Application for [Position] - [Your Name]", text: $subjectLine)
                            .font(.system(size: 14))
                            .padding(12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.baseStroke, lineWidth: 1)
                            )
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Body Template")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)

                        TextEditor(text: $bodyContent)
                            .font(.system(size: 13))
                            .lineSpacing(4)
                            .frame(minHeight: 160)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.baseStroke, lineWidth: 1)
                            )
                    }
                }
                .padding(16)
            }
            .background(Color(hex: "#F8FAFC"))
            .navigationTitle("Create Template")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Color(hex: "#737373"))
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let parsedTags = rawTags
                            .components(separatedBy: ",")
                            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                            .filter { !$0.isEmpty }

                        let newTemplate = EmailTemplateModel(
                            title: templateTitle.isEmpty ? "Untitled Template" : templateTitle,
                            tags: parsedTags.isEmpty ? ["General"] : parsedTags,
                            subject: subjectLine,
                            body: bodyContent
                        )
                        onSave?(newTemplate)
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(Color.bgPrimary)
                    .disabled(templateTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    CreateEmailTemplateSheetView()
}
