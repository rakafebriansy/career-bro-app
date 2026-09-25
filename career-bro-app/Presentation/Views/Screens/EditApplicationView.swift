import SwiftUI
import SwiftData

struct EditApplicationView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let job: JobApplicationModel
    
    @State private var company: String
    @State private var position: String
    @State private var location: String
    @State private var earn: String
    @State private var jobType: EmploymentTypeEnum
    @State private var workType: WorkLocationTypeEnum
    @State private var education: String
    @State private var experience: String
    @State private var benefit: String
    
    init(job: JobApplicationModel) {
        self.job = job
        _company = State(initialValue: job.company)
        _position = State(initialValue: job.position)
        _location = State(initialValue: job.location ?? "")
        
        if let min = job.salaryMin, let max = job.salaryMax {
            _earn = State(initialValue: "\(Int(min / 1_000_000))-\(Int(max / 1_000_000))M")
        } else if let min = job.salaryMin {
            _earn = State(initialValue: "\(Int(min / 1_000_000))M")
        } else {
            _earn = State(initialValue: "")
        }
        
        _jobType = State(initialValue: job.employment)
        _workType = State(initialValue: job.workLocation)
        _education = State(initialValue: job.requirements?.first ?? "")
        _experience = State(initialValue: job.requirements?.dropFirst().first ?? "")
        _benefit = State(initialValue: (job.attachments ?? []).joined(separator: ", "))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    generalSection
                    workDetailsSection
                    qualificationsSection
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color(hex: "F8FAFC"))
            .navigationTitle("Edit Application")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(Color.blue)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.blue)
                }
            }
        }
    }
    
    private var generalSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("General Information")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.black)
            
            VStack(spacing: 14) {
                JobFormFieldView(title: "Company", placeholder: "Company Name", text: $company)
                JobFormFieldView(title: "Position", placeholder: "Position Title", text: $position)
                JobFormFieldView(title: "Location", placeholder: "Job Location", text: $location)
                JobFormFieldView(title: "Earn", placeholder: "Salary Range", text: $earn)
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
    }
    
    private var workDetailsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Work Details")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.black)
            
            VStack(spacing: 14) {
                JobPickerFormFieldView(
                    title: "Job",
                    options: EmploymentTypeEnum.allCases,
                    selection: $jobType
                )
                
                JobPickerFormFieldView(
                    title: "Type",
                    options: WorkLocationTypeEnum.allCases,
                    selection: $workType
                )
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
    }
    
    private var qualificationsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Qualifications & Benefits")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.black)
            
            VStack(spacing: 14) {
                JobFormFieldView(title: "Education", placeholder: "Education Requirement", text: $education)
                JobFormFieldView(title: "Experience", placeholder: "Experience Level", text: $experience)
                JobFormFieldView(title: "Benefit", placeholder: "Benefits & Perks", text: $benefit)
            }
            .padding(16)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
    }
    
    private func saveChanges() {
        job.company = company
        job.position = position
        job.location = location.isEmpty ? nil : location
        job.employment = jobType
        job.workLocation = workType
        job.updatedAt = Date()
        try? modelContext.save()
    }
}

#Preview {
    let sample = SwiftDataSeeder.fetchFirstSample(context: SwiftDataSeeder.previewContainer.mainContext)
    return EditApplicationView(job: sample)
        .modelContainer(SwiftDataSeeder.previewContainer)
}
