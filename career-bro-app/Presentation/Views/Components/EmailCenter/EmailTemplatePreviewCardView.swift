import SwiftUI

struct EmailTemplatePreviewCardView: View {
    let title: String
    let tags: [String]
    let subject: String
    let bodyText: String
    
    @State private var isExpanded: Bool = true
    
    private var renderedSubject: String {
        subject.isEmpty ? "(No Subject)" : formatSampleVariables(subject)
    }
    
    private var renderedBody: String {
        bodyText.isEmpty ? "(No Body Content)" : formatSampleVariables(bodyText)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "eye.fill")
                            .font(.caption)
                            .foregroundStyle(Color.bgPrimary)
                        
                        Text("Live Preview")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.textPrimary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundStyle(Color(hex: "#737373"))
                }
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    if !tags.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 6) {
                                ForEach(tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundStyle(Color.bgPrimary)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(Color(hex: "#EFF6FF"))
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Subject:")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "#737373"))
                        
                        Text(renderedSubject)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.textPrimary)
                    }
                    
                    Divider()
                        .foregroundStyle(Color.baseStroke)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Message Body:")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color(hex: "#737373"))
                        
                        Text(renderedBody)
                            .font(.system(size: 12))
                            .foregroundStyle(.textPrimary)
                            .lineSpacing(3)
                    }
                }
                .padding(14)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
            }
        }
    }
    
    private func formatSampleVariables(_ input: String) -> String {
        input
            .replacingOccurrences(of: "[Company Name]", with: "Tech Corp")
            .replacingOccurrences(of: "[Job Title]", with: "Senior Developer")
            .replacingOccurrences(of: "[Your Name]", with: "Raka Febrian")
            .replacingOccurrences(of: "[Portfolio URL]", with: "https://portfolio.me")
            .replacingOccurrences(of: "[Application Date]", with: "28 Sep 2026")
            .replacingOccurrences(of: "[Hiring Manager]", with: "Hiring Team")
    }
}

#Preview {
    EmailTemplatePreviewCardView(
        title: "Template Follow-Up",
        tags: ["Fullstack", "UI/UX"],
        subject: "Application for [Job Title] at [Company Name]",
        bodyText: "Dear [Hiring Manager],\n\nI am writing to express my interest in the [Job Title] role at [Company Name]."
    )
    .padding()
}
