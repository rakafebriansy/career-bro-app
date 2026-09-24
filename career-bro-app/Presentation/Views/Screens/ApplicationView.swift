//
//  ApplicationView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import SwiftUI

struct ApplicationView: View {
    enum ViewMode: String, CaseIterable {
        case kanban = "Kanban"
        case checklist = "Checklist"
    }
    
    @State private var selectedMode: ViewMode = .kanban
    @State private var searchText: String = ""
    @State private var isSearchActive: Bool = false
    @State private var applications: [JobApplicationModel] = JobApplicationModel.dummyData
    @State private var checkedJobIds: Set<UUID> = JobApplicationModel.dummyData.first.map { Set([$0.id]) } ?? []
    @State private var isAddMenuExpanded: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
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
                
                if isAddMenuExpanded {
                    Color.black.opacity(0.35)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                isAddMenuExpanded = false
                            }
                        }
                }
                
                VStack(alignment: .trailing, spacing: 12) {
                    if isAddMenuExpanded {
                        addMenuOptionsView
                            .transition(.opacity.combined(with: .scale(scale: 0.9, anchor: .bottomTrailing)).combined(with: .offset(y: 8)))
                    }
                    
                    floatingAddButton
                }
                .padding(.trailing, 20)
                .padding(.bottom, 24)
            }
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
            
            HStack(spacing: 8) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isSearchActive.toggle()
                    }
                }) {
                    Image(systemName: "magnifyingglass")
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
                
                Button(action: {
                    // Filter action
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
        }
        .padding(.horizontal)
    }
    
    private var controlBarSection: some View {
        VStack(spacing: 12) {
            if isSearchActive {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.baseText)
                    TextField("Search applications or companies...", text: $searchText)
                        .font(.subheadline)
                    if !searchText.isEmpty {
                        Button {
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.baseText)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
            
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
                
                Button(action: {
                    // Email sync action
                }) {
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
    }
    
    private var kanbanBoardView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 16) {
                ForEach(JobStatus.allCases, id: \.self) { status in
                    kanbanColumn(for: status)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 80)
        }
    }
    
    private func kanbanColumn(for status: JobStatus) -> some View {
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
                            JobCardView(job: job, showHeader: false)
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
                ForEach(JobStatus.allCases, id: \.self) { status in
                    checklistSection(for: status)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 90)
        }
    }
    
    private func checklistSection(for status: JobStatus) -> some View {
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
                }
            }
        }
    }
    
    private var addMenuOptionsView: some View {
        VStack(alignment: .trailing, spacing: 10) {
            menuPillButton(
                title: "Paste Text",
                icon: "doc.text",
                tintColor: Color(hex: "9333EA"),
                bgColor: Color(hex: "F3E8FF")
            ) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    isAddMenuExpanded = false
                }
            }
            
            menuPillButton(
                title: "Scan Image",
                icon: "camera",
                tintColor: Color(hex: "EA580C"),
                bgColor: Color(hex: "FFF4E5")
            ) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    isAddMenuExpanded = false
                }
            }
            
            menuPillButton(
                title: "Import URL",
                icon: "link",
                tintColor: Color(hex: "2563EB"),
                bgColor: Color(hex: "E0F2FE")
            ) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    isAddMenuExpanded = false
                }
            }
            
            menuPillButton(
                title: "Voice Input",
                icon: "mic",
                tintColor: Color(hex: "4B5563"),
                bgColor: Color(hex: "F3F4F6")
            ) {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    isAddMenuExpanded = false
                }
            }
        }
    }
    
    private func menuPillButton(
        title: String,
        icon: String,
        tintColor: Color,
        bgColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .frame(width: 20, alignment: .center)
                Text(title)
                    .font(.system(size: 15, weight: .medium))
            }
            .foregroundStyle(tintColor)
            .frame(width: 155, height: 44)
            .background(bgColor)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.08), radius: 4, y: 2)
        }
    }
    
    private var floatingAddButton: some View {
        Button(action: {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                isAddMenuExpanded.toggle()
            }
        }) {
            Image(systemName: "plus")
                .font(.system(size: 26, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 60, height: 60)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.blue.opacity(0.35), radius: 8, y: 4)
        }
    }
    
    private func filteredJobs(for status: JobStatus) -> [JobApplicationModel] {
        applications.filter { job in
            let matchesStatus = job.status == status
            if searchText.isEmpty {
                return matchesStatus
            } else {
                return matchesStatus && (
                    job.company.localizedCaseInsensitiveContains(searchText) ||
                    job.position.localizedCaseInsensitiveContains(searchText)
                )
            }
        }
    }
    
    private var filteredAllJobs: [JobApplicationModel] {
        if searchText.isEmpty {
            return applications
        } else {
            return applications.filter { job in
                job.company.localizedCaseInsensitiveContains(searchText) ||
                job.position.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    ApplicationView()
}
