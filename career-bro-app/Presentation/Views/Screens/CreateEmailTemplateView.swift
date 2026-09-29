//
//  CreateEmailTemplateView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CreateEmailTemplateView: View {
    @Environment(\.dismiss) private var dismiss

    var onSave: ((EmailTemplateModel) -> Void)? = nil

    @State private var templateTitle: String = ""
    @State private var selectedTags: [String] = ["Fullstack"]
    @State private var subjectLine: String = ""
    @State private var bodyContent: String = ""
    @State private var activeFieldIsSubject: Bool = false
    @State private var showSaveToast: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    titleInputField

                    EmailTemplateTagSelectorView(selectedTags: $selectedTags)

                    subjectInputField

                    EmailPlaceholderChipsToolbarView { placeholder in
                        if activeFieldIsSubject {
                            subjectLine += " " + placeholder
                        } else {
                            bodyContent += " " + placeholder
                        }
                    }

                    bodyInputField

                    EmailTemplatePreviewCardView(
                        title: templateTitle,
                        tags: selectedTags,
                        subject: subjectLine,
                        bodyText: bodyContent
                    )

                    saveButton
                        .padding(.top, 8)
                        .padding(.bottom, 24)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
            }
            .background(Color(hex: "#F8FAFC"))
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var topNavigationBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.body)
                    .fontWeight(.medium)
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

            Text("Create Template")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            Spacer()

            Button {
                saveTemplate()
            } label: {
                Text("Save")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(isFormValid ? Color.bgPrimary : Color(hex: "#9CA3AF"))
            }
            .buttonStyle(.plain)
            .disabled(!isFormValid)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }

    private var titleInputField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Template Title")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            TextField("e.g. Template Follow-Up HR", text: $templateTitle)
                .font(.system(size: 14))
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
        }
    }

    private var subjectInputField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Email Subject")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            TextField("e.g. Application for [Job Title] - [Your Name]", text: $subjectLine)
                .font(.system(size: 14))
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(activeFieldIsSubject ? Color.bgPrimary : Color.baseStroke, lineWidth: activeFieldIsSubject ? 1.5 : 1)
                )
                .onTapGesture {
                    activeFieldIsSubject = true
                }
        }
    }

    private var bodyInputField: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("Email Body Template")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.textPrimary)

                Spacer()

                Text("\(bodyContent.count) chars")
                    .font(.caption2)
                    .foregroundStyle(Color(hex: "#737373"))
            }

            TextEditor(text: $bodyContent)
                .font(.system(size: 13))
                .lineSpacing(4)
                .frame(minHeight: 180)
                .padding(10)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(!activeFieldIsSubject ? Color.bgPrimary : Color.baseStroke, lineWidth: !activeFieldIsSubject ? 1.5 : 1)
                )
                .onTapGesture {
                    activeFieldIsSubject = false
                }
        }
    }

    private var saveButton: some View {
        Button {
            saveTemplate()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "checkmark.circle.fill")
                Text("Save Template")
            }
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(isFormValid ? Color.bgPrimary : Color(hex: "#9CA3AF"))
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .disabled(!isFormValid)
    }

    private var isFormValid: Bool {
        !templateTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !bodyContent.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    private func saveTemplate() {
        guard isFormValid else { return }
        let newTemplate = EmailTemplateModel(
            title: templateTitle.trimmingCharacters(in: .whitespacesAndNewlines),
            tags: selectedTags.isEmpty ? ["General"] : selectedTags,
            subject: subjectLine.trimmingCharacters(in: .whitespacesAndNewlines),
            body: bodyContent
        )
        onSave?(newTemplate)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        CreateEmailTemplateView()
    }
}
