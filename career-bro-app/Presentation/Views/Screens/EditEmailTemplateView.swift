//
//  EditEmailTemplateView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct EditEmailTemplateView: View {
    @Environment(\.dismiss) private var dismiss

    @State var template: EmailTemplateModel
    var onUpdate: ((EmailTemplateModel) -> Void)? = nil
    var onDelete: ((EmailTemplateModel) -> Void)? = nil

    @State private var showDeleteConfirmation: Bool = false
    @State private var showEditSheet: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    EmailTemplateBodyCardView(bodyText: template.body)

                    attachmentSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            .background(Color.white)

            bottomActionBar
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .alert("Delete Template", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete?(template)
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \"\(template.title)\"? This action cannot be undone.")
        }
        .sheet(isPresented: $showEditSheet) {
            EditEmailTemplateModalSheetView(template: template) { updatedTemplate in
                self.template = updatedTemplate
                onUpdate?(updatedTemplate)
            }
        }
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

            Text(template.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            Spacer()

            Color.clear
                .frame(width: 40, height: 40)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }

    private var attachmentSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Attachment")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            if template.attachments.isEmpty {
                Text("No attachments attached.")
                    .font(.caption)
                    .foregroundStyle(Color(hex: "#9CA3AF"))
                    .padding(.vertical, 8)
            } else {
                VStack(spacing: 12) {
                    ForEach(template.attachments) { attachment in
                        EmailAttachmentCardView(attachment: attachment) {
                            withAnimation {
                                template.attachments.removeAll { $0.id == attachment.id }
                                onUpdate?(template)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var bottomActionBar: some View {
        HStack(spacing: 14) {
            Button {
                showDeleteConfirmation = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "trash.fill")
                        .font(.system(size: 14))
                    Text("Delete")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .foregroundStyle(Color(hex: "#EF4444"))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color(hex: "#EF4444"), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            Button {
                showEditSheet = true
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "pencil")
                        .font(.system(size: 14, weight: .bold))
                    Text("Edit")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.bgPrimary)
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.top, 12)
        .padding(.bottom, 24)
        .background(Color.white)
    }
}

#Preview {
    NavigationStack {
        EditEmailTemplateView(
            template: EmailTemplateModel.sampleTemplates[0]
        )
    }
}
