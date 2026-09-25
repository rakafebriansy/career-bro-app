import SwiftUI
import SwiftData

struct SearchView: View {
    @Query(sort: \JobApplicationModel.createdAt, order: .reverse) private var applications: [JobApplicationModel]
    @State private var searchText: String = ""
    @State private var selectedStatus: JobStatusEnum? = nil
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    filterChipSection
                    
                    if filteredApplications.isEmpty {
                        emptyStateView
                    } else {
                        resultsListSection
                    }
                }
                .padding(.vertical, 12)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Search")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search jobs, companies, or keywords..."
            )
        }
    }
    
    private var filterChipSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedStatus = nil
                    }
                } label: {
                    Text("All (\(applications.count))")
                        .font(.subheadline)
                        .fontWeight(selectedStatus == nil ? .semibold : .regular)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .background(selectedStatus == nil ? Color.blue : Color(.secondarySystemGroupedBackground))
                        .foregroundStyle(selectedStatus == nil ? Color.white : Color.primary)
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(selectedStatus == nil ? Color.clear : Color.baseStroke, lineWidth: 1)
                        )
                }
                
                ForEach(JobStatusEnum.allCases, id: \.self) { status in
                    let count = applications.filter { $0.status == status }.count
                    if count > 0 {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                if selectedStatus == status {
                                    selectedStatus = nil
                                } else {
                                    selectedStatus = status
                                }
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Text(status.rawValue)
                                Text("\(count)")
                                    .font(.caption2)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(selectedStatus == status ? Color.white.opacity(0.2) : Color(.tertiarySystemFill))
                                    .clipShape(Capsule())
                            }
                            .font(.subheadline)
                            .fontWeight(selectedStatus == status ? .semibold : .regular)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(selectedStatus == status ? Color.blue : Color(.secondarySystemGroupedBackground))
                            .foregroundStyle(selectedStatus == status ? Color.white : Color.primary)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(selectedStatus == status ? Color.clear : Color.baseStroke, lineWidth: 1)
                            )
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var resultsListSection: some View {
        LazyVStack(spacing: 12) {
            HStack {
                Text("\(filteredApplications.count) Applications Found")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal)
            
            ForEach(filteredApplications) { job in
                NavigationLink(destination: ApplicationDetailView(job: job)) {
                    JobCardView(job: job, showHeader: true)
                }
                .buttonStyle(.plain)
                .padding(.horizontal)
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
                .padding(.top, 40)
            
            Text("No Applications Found")
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text("We couldn't find any job application matching \"\(searchText)\". Try searching for a different role or company.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
    
    private var filteredApplications: [JobApplicationModel] {
        applications.filter { job in
            let matchesStatus = selectedStatus == nil || job.status == selectedStatus
            
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return matchesStatus
            }
            
            let query = searchText.lowercased()
            let matchesCompany = job.company.lowercased().contains(query)
            let matchesPosition = job.position.lowercased().contains(query)
            let matchesLocation = (job.location ?? "").lowercased().contains(query)
            let matchesKeywords = (job.keywords ?? []).contains { $0.lowercased().contains(query) }
            let matchesEmployment = job.employment.rawValue.lowercased().contains(query)
            let matchesStatusText = job.status.rawValue.lowercased().contains(query)
            
            return matchesStatus && (
                matchesCompany ||
                matchesPosition ||
                matchesLocation ||
                matchesKeywords ||
                matchesEmployment ||
                matchesStatusText
            )
        }
    }
}

#Preview {
    SearchView()
        .modelContainer(SwiftDataSeeder.previewContainer)
}
