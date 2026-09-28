//
//  EditEmailTemplateModalSheetView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct EditEmailTemplateModalSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var templateTitle: String
    @State private var selectedTags: [String]
    @State private var subjectLine: String
    @State private var bodyContent: String
    @State private var activeFieldIsSubject: Bool = false
    
    var onSave: ((EmailTemplateModel) -> Void)? = nil
    
    init(template: EmailTemplateModel, onSave: ((EmailTemplateModel) -> Void)? = nil) {
        _templateTitle = State(initialValue: template.title)
        _selectedTags = State(initialValue: template.tags)
        _subjectLine = State(initialValue: template.subject)
        _bodyContent = State(initialValue: template.body)
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
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
                }
                .padding(16)
            }
            .background(Color(hex: "#F8FAFC"))
            .navigationTitle("Edit Template")
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
                        let updated = EmailTemplateModel(
                            title: templateTitle.trimmingCharacters(in: .whitespacesAndNewlines),
                            tags: selectedTags.isEmpty ? ["General"] : selectedTags,
                            subject: subjectLine.trimmingCharacters(in: .whitespacesAndNewlines),
                            body: bodyContent
                        )
                        onSave?(updated)
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(Color.bgPrimary)
                    .disabled(templateTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private var titleInputField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Template Title")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            TextField("Template Name", text: $templateTitle)
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
            
            TextField("Subject Line", text: $subjectLine)
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
                .frame(minHeight: 200)
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
}

#Preview {
    EditEmailTemplateModalSheetView(
        template: EmailTemplateModel.sampleTemplates[0]
    )
}
