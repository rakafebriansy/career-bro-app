//
//  ApplicationDetailView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import SwiftData

struct ApplicationDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var showDeleteConfirmation: Bool = false
    @State private var isEditingApplication: Bool = false

    let job: JobApplicationModel

    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    ApplicationTimelineStepperView(status: job.status)
                        .padding(.top, 8)

                    JobOverviewCardView(job: job)

                    if let deadlineInfo = job.deadlineInfo {
                        JobDeadlineBannerView(deadlineInfo: deadlineInfo)
                    }

                    jobInformationSection

                    if let suggestion = job.aiSuggestion {
                        AISuggestionCardView(
                            title: "AI Suggestion",
                            message: suggestion
                        )
                    }

                    attachmentSection

                    stageActionSection
                        .padding(.top, 10)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
        .background(Color(.systemGroupedBackground).opacity(0.15))
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $isEditingApplication) {
            EditApplicationView(job: job)
        }
        .alert("Delete Application", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                modelContext.delete(job)
                try? modelContext.save()
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this job application? This action cannot be undone.")
        }
    }

    private var topNavigationBar: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.black)
                    .frame(width: 38, height: 38)
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 1)
                    )
            }

            Spacer()

            Text("Application Detail")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(Color.black)

            Spacer()

            Menu {
                Button {
                    isEditingApplication = true
                } label: {
                    Label("Edit Application", systemImage: "pencil")
                }

                Menu {
                    Section("Active Pipeline") {
                        statusMenuItem(for: .needToApply)
                        statusMenuItem(for: .applied)
                        statusMenuItem(for: .assessment)
                        statusMenuItem(for: .interview)
                        statusMenuItem(for: .postInterview)
                    }

                    Section("Outcomes & Decisions") {
                        statusMenuItem(for: .offered)
                        statusMenuItem(for: .accepted)
                        statusMenuItem(for: .rejected)
                        statusMenuItem(for: .ghosted)
                    }
                } label: {
                    Label("Change Stage", systemImage: "arrow.left.arrow.right")
                }

                Divider()

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Label("Delete Application", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.black)
                    .frame(width: 38, height: 38)
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
    }

    private var jobInformationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Job Information")
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(Color.black)

            VStack(alignment: .leading, spacing: 10) {
                JobInfoRowView(icon: "briefcase", text: job.employment.rawValue)
                JobInfoRowView(icon: "laptopcomputer", text: job.workLocation.rawValue)

                if let location = job.location {
                    JobInfoRowView(icon: "laptopcomputer", text: location)
                }

                if let requirements = job.requirements {
                    ForEach(requirements.filter { !isDuplicateWorkLocation($0) }, id: \.self) { req in
                        JobInfoRowView(icon: iconForRequirement(req), text: req)
                    }
                }
            }
            .padding(.top, 2)

            if let description = job.jobDescription {
                Text(description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color.black.opacity(0.65))
                    .lineSpacing(3)
                    .padding(.top, 4)
            }

            if let keywords = job.keywords, !keywords.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Key Word :")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.black)

                    KeywordChipsFlowView(keywords: keywords)
                }
                .padding(.top, 4)
            }
        }
    }

    private var attachmentSection: some View {
        let attachmentsList = [job.jobUrl].compactMap { $0 } + (job.attachments ?? [])

        return Group {
            if !attachmentsList.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Attachment")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.black)

                    VStack(spacing: 8) {
                        ForEach(attachmentsList, id: \.self) { item in
                            AttachmentRowView(title: item)
                        }
                    }
                }
            }
        }
    }

    private var stageActionSection: some View {
        HStack(spacing: 12) {
            Menu {
                Section("Active Pipeline") {
                    statusMenuItem(for: .needToApply)
                    statusMenuItem(for: .applied)
                    statusMenuItem(for: .assessment)
                    statusMenuItem(for: .interview)
                    statusMenuItem(for: .postInterview)
                }

                Section("Outcomes & Decisions") {
                    statusMenuItem(for: .offered)
                    statusMenuItem(for: .accepted)
                    statusMenuItem(for: .rejected)
                    statusMenuItem(for: .ghosted)
                }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.system(size: 13, weight: .semibold))
                    Text("Change Stage")
                        .font(.system(size: 14, weight: .semibold))
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 11, weight: .medium))
                }
                .foregroundStyle(Color.blue)
                .padding(.horizontal, 14)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue.opacity(0.08))
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.blue.opacity(0.25), lineWidth: 1)
                )
            }

            Button(action: {
                advanceStage()
            }) {
                HStack(spacing: 8) {
                    Text(nextStageTitle)
                        .font(.system(size: 15, weight: .semibold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(isAtFinalStage ? Color.gray.opacity(0.6) : Color.blue)
                .clipShape(Capsule())
                .shadow(color: isAtFinalStage ? Color.clear : Color.blue.opacity(0.25), radius: 6, y: 3)
            }
            .disabled(isAtFinalStage)
        }
    }

    @ViewBuilder
    private func statusMenuItem(for status: JobStatusEnum) -> some View {
        Button {
            setStage(status)
        } label: {
            HStack {
                Text(status.rawValue)
                if job.status == status {
                    Image(systemName: "checkmark")
                }
            }
        }
    }

    private func setStage(_ newStatus: JobStatusEnum) {
        withAnimation(.easeInOut(duration: 0.25)) {
            job.status = newStatus
            job.updatedAt = Date()
            try? modelContext.save()
        }
    }

    private func advanceStage() {
        switch job.status {
        case .needToApply:
            setStage(.applied)
        case .applied:
            setStage(.assessment)
        case .assessment:
            setStage(.interview)
        case .interview:
            setStage(.postInterview)
        case .postInterview:
            setStage(.offered)
        case .offered:
            setStage(.accepted)
        case .accepted, .rejected, .ghosted:
            break
        }
    }

    private var isAtFinalStage: Bool {
        job.status == .accepted || job.status == .rejected || job.status == .ghosted
    }

    private var nextStageTitle: String {
        switch job.status {
        case .needToApply:
            return "Move Applied"
        case .applied:
            return "Move Assessment"
        case .assessment:
            return "Move Interview"
        case .interview:
            return "Move Post-Interview"
        case .postInterview:
            return "Move Offer"
        case .offered:
            return "Accept Offer"
        case .accepted:
            return "Completed"
        case .rejected, .ghosted:
            return "Archive"
        }
    }

    private func isDuplicateWorkLocation(_ req: String) -> Bool {
        req.caseInsensitiveCompare(job.employment.rawValue) == .orderedSame ||
        req.caseInsensitiveCompare(job.workLocation.rawValue) == .orderedSame
    }

    private func iconForRequirement(_ req: String) -> String {
        let lower = req.lowercased()
        if lower.contains("s1") || lower.contains("degree") || lower.contains("bachelor") || lower.contains("art") || lower.contains("computer") {
            return "graduationcap"
        } else if lower.contains("year") || lower.contains("exp") {
            return "clock"
        } else if lower.contains("cv") || lower.contains("portfolio") || lower.contains("resume") {
            return "doc.text"
        } else if lower.contains("hybrid") || lower.contains("remote") || lower.contains("onsite") {
            return "laptopcomputer"
        } else {
            return "checkmark.circle"
        }
    }
}

#Preview {
    let sample = SwiftDataSeeder.fetchFirstSample(context: SwiftDataSeeder.previewContainer.mainContext)
    return ApplicationDetailView(job: sample)
        .modelContainer(SwiftDataSeeder.previewContainer)
}
