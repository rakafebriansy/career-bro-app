//
//  HomeView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import Charts
import SwiftData

struct HomeView: View {
    enum ViewMode: String, CaseIterable {
        case kanban = "Kanban"
        case checklist = "Checklist"
    }

    @Environment(\.modelContext) private var modelContext
    @Environment(AppNavigationRouter.self) private var router: AppNavigationRouter?
    @Query(sort: \JobApplicationModel.createdAt, order: .reverse) private var applications: [JobApplicationModel]
    @State private var selectedMode: ViewMode = .kanban
    @State private var checkedJobIds: Set<UUID> = []
    @State private var navigatedJob: JobApplicationModel? = nil

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Good Morning")
                            .font(.subheadline)
                            .foregroundStyle(.baseText)
                        Text("Raka Febrian")
                            .font(.title2)
                            .fontWeight(.bold)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Journey Summary")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)

                        JourneySummaryView(SwiftDataSeeder.computeJourneySummary(from: applications))
                    }

                    HStack(alignment: .center, spacing: 12) {
                        Image(systemName: "sparkles.2")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color.baseWhite)
                            .frame(width: 32, height: 32)
                            .background(Color.bgPrimary)
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 2) {
                            Text("AI Insight")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(Color.bgPrimary)
                            Text("You’ve applied to 10 Product Designer roles. Consider expanding to UI/UX Designer opportunities")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.bgPrimary.opacity(0.85))
                                .lineLimit(2)
                                .lineSpacing(1.5)
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: "EEECFE"))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

                    VStack(alignment: .leading, spacing: 16) {
                        pipelineHeaderSection
                        controlBarSection

                        if selectedMode == .kanban {
                            kanbanBoardView
                        } else {
                            checklistView
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 28)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            .navigationDestination(item: $navigatedJob) { job in
                ApplicationDetailView(job: job)
            }
            .onChange(of: router?.activeJobDetailId) { _, newId in
                checkAndNavigateToJob(id: newId)
            }
            .onAppear {
                checkAndNavigateToJob(id: router?.activeJobDetailId)
            }
        }
    }

    private func openJobDetail(_ job: JobApplicationModel) {
        navigatedJob = job
    }

    private func checkAndNavigateToJob(id: UUID?) {
        guard let id = id else { return }
        if let matched = applications.first(where: { $0.id == id }) {
            navigatedJob = matched
            router?.activeJobDetailId = nil
        }
    }

    private var pipelineHeaderSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Applications")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            Text("Track your professional progression")
                .font(.subheadline)
                .foregroundStyle(Color(hex: "8F8EAA"))
        }
    }

    private var controlBarSection: some View {
        HStack {
            HStack(spacing: 4) {
                Button {
                    selectedMode = .kanban
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "rectangle.split.3x1")
                        Text("Kanban")
                    }
                    .font(.subheadline)
                    .fontWeight(selectedMode == .kanban ? .semibold : .regular)
                    .foregroundStyle(selectedMode == .kanban ? Color.blue : .baseText)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selectedMode == .kanban ? Color(.systemBackground) : Color.clear)
                            .shadow(color: selectedMode == .kanban ? Color.black.opacity(0.06) : Color.clear, radius: 2, y: 1)
                    )
                }
                .buttonStyle(.plain)

                Button {
                    selectedMode = .checklist
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "list.bullet.clipboard")
                        Text("Checklist")
                    }
                    .font(.subheadline)
                    .fontWeight(selectedMode == .checklist ? .semibold : .regular)
                    .foregroundStyle(selectedMode == .checklist ? Color.blue : .baseText)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selectedMode == .checklist ? Color(.systemBackground) : Color.clear)
                            .shadow(color: selectedMode == .checklist ? Color.black.opacity(0.06) : Color.clear, radius: 2, y: 1)
                    )
                }
                .buttonStyle(.plain)
            }
            .padding(3)
            .background(Color(hex: "F0F1F5"))
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Spacer()

            Menu {
                Button {
                } label: {
                    Label("Paste Text", systemImage: "doc.text")
                }

                Button {
                } label: {
                    Label("Scan Image", systemImage: "camera")
                }

                Button {
                } label: {
                    Label("Import URL", systemImage: "link")
                }

                Button {
                } label: {
                    Label("Voice Input", systemImage: "mic")
                }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "envelope")
                    Text("Email")
                }
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color.blue)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
            }
        }
    }

    private var kanbanBoardView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(JobStatusEnum.allCases, id: \.self) { status in
                    kanbanColumn(for: status)
                }
            }
            .padding(.vertical, 4)
        }
    }

    private func kanbanColumn(for status: JobStatusEnum) -> some View {
        let jobs = filteredJobs(for: status)

        return VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text(status.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)

                Text("\(jobs.count)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black.opacity(0.6))
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(Color(hex: "E5E6EB"))
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                Spacer()
            }

            VStack(spacing: 12) {
                if jobs.isEmpty {
                    VStack(spacing: 6) {
                        Text("No Applications")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.baseText)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                            .foregroundStyle(Color.baseStroke)
                    )
                } else {
                    ForEach(jobs) { job in
                        Button {
                            openJobDetail(job)
                        } label: {
                            JobCardView(job: job, showHeader: false)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .frame(width: 290)
    }

    private var checklistView: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(JobStatusEnum.allCases, id: \.self) { status in
                checklistSection(for: status)
            }
        }
    }

    private func checklistSection(for status: JobStatusEnum) -> some View {
        let jobs = filteredJobs(for: status)
        let isActionable = status != .offered && status != .accepted && status != .rejected && status != .ghosted

        return VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Text(status.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)

                Text("\(jobs.count)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black.opacity(0.6))
                    .padding(.horizontal, 7)
                    .padding(.vertical, 3)
                    .background(Color(hex: "E5E6EB"))
                    .clipShape(RoundedRectangle(cornerRadius: 4))

                Spacer()
            }

            if jobs.isEmpty {
                VStack(spacing: 6) {
                    Text("No Applications")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(.baseText)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [4]))
                        .foregroundStyle(Color.baseStroke)
                )
            } else {
                VStack(spacing: 12) {
                    ForEach(jobs) { job in
                        Button {
                            openJobDetail(job)
                        } label: {
                            JobCardView(
                                job: job,
                                showHeader: false,
                                showCheckbox: isActionable,
                                isChecked: checkedJobIds.contains(job.id),
                                onToggleCheck: {
                                    if checkedJobIds.contains(job.id) {
                                        checkedJobIds.remove(job.id)
                                    } else {
                                        checkedJobIds.insert(job.id)
                                    }
                                }
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private func filteredJobs(for status: JobStatusEnum) -> [JobApplicationModel] {
        applications.filter { $0.status == status }
    }
}

#Preview {
    HomeView()
        .modelContainer(SwiftDataSeeder.previewContainer)
}
