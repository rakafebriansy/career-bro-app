import SwiftUI

struct EmailCenterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var templates: [EmailTemplateModel] = EmailTemplateModel.sampleTemplates
    @State private var selectedTemplateForDetail: EmailTemplateModel? = nil
    @State private var navigateToDetail: Bool = false
    @State private var navigateToCreateTemplate: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 18) {
                    headerSection
                    
                    VStack(spacing: 0) {
                        ForEach(templates) { template in
                            EmailTemplateRowView(template: template) {
                                selectedTemplateForDetail = template
                                navigateToDetail = true
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color.white)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $navigateToDetail) {
            if let template = selectedTemplateForDetail {
                EditEmailTemplateView(
                    template: template,
                    onUpdate: { updated in
                        if let index = templates.firstIndex(where: { $0.id == updated.id }) {
                            templates[index] = updated
                        }
                    },
                    onDelete: { deleted in
                        templates.removeAll { $0.id == deleted.id }
                    }
                )
            }
        }
        .navigationDestination(isPresented: $navigateToCreateTemplate) {
            CreateEmailTemplateView { newTemplate in
                templates.append(newTemplate)
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
            
            Text("Email Center")
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
    
    private var headerSection: some View {
        HStack(alignment: .center) {
            Text("Template")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            Spacer()
            
            Button {
                navigateToCreateTemplate = true
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "plus")
                        .font(.system(size: 13, weight: .bold))
                    
                    Text("Create New")
                        .font(.system(size: 13, weight: .semibold))
                }
                .foregroundStyle(Color.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Color.bgPrimary)
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    NavigationStack {
        EmailCenterView()
    }
}
