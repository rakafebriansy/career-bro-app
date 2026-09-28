//
//  ApplicationView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI
import SwiftData

struct ApplicationView: View {
    enum ViewMode: String, CaseIterable {
        case kanban = "Kanban"
        case checklist = "Checklist"
    }
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JobApplicationModel.createdAt, order: .reverse) private var applications: [JobApplicationModel]
    @State private var selectedMode: ViewMode = .kanban
    @State private var checkedJobIds: Set<UUID> = []
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                headerSection
                controlBarSection
                    .padding(.bottom, 10)
                
                if selectedMode == .kanban {
                    kanbanBoardView
                } else {
                    checklistView
                }
            }
            .padding(.top, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color(.systemBackground))
        }
    }
    
    private var headerSection: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Application Pipeline")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.textPrimary)
                
                Text("Track your professional progression")
                    .font(.subheadline)
                    .foregroundStyle(Color(hex: "8F8EAA"))
            }
            
            Spacer()
            
            Button(action: {
            }) {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.textPrimary)
                    .frame(width: 38, height: 38)
                    .background(Color(.systemBackground))
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal)
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
        .padding(.horizontal)
    }
    
    private var kanbanBoardView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(JobStatusEnum.allCases, id: \.self) { status in
                    kanbanColumn(for: status)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
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
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 12) {
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
                            NavigationLink(destination: ApplicationDetailView(job: job)) {
                                JobCardView(job: job, showHeader: false)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.vertical, 2)
            }
        }
        .frame(width: 290)
    }
    
    private var checklistView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(JobStatusEnum.allCases, id: \.self) { status in
                    checklistSection(for: status)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 24)
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
                        NavigationLink(destination: ApplicationDetailView(job: job)) {
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
    ApplicationView()
        .modelContainer(SwiftDataSeeder.previewContainer)
}
