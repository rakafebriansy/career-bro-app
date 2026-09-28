import SwiftUI

struct EmailTemplateBodyCardView: View {
    let bodyText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Email Body")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            Text(attributedContent)
                .font(.system(size: 13))
                .foregroundStyle(Color(hex: "#374151"))
                .lineSpacing(4)
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.baseStroke, lineWidth: 1)
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var attributedContent: AttributedString {
        var attributed = AttributedString(bodyText)
        let highlightTokens = ["{name}", "{company}", "[Your Name]", "[Company Name]", "[Job Title]", "[Position Title]", "[Date]"]
        
        for token in highlightTokens {
            var searchRange = attributed.startIndex..<attributed.endIndex
            while let range = attributed[searchRange].range(of: token) {
                attributed[range].foregroundColor = Color.bgPrimary
                attributed[range].inlinePresentationIntent = .stronglyEmphasized
                if range.upperBound < attributed.endIndex {
                    searchRange = range.upperBound..<attributed.endIndex
                } else {
                    break
                }
            }
        }
        return attributed
    }
}

#Preview {
    EmailTemplateBodyCardView(
        bodyText: EmailTemplateModel.sampleTemplates[0].body
    )
    .padding()
}
