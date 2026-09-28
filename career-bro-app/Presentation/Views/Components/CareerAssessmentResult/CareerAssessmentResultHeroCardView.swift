import SwiftUI

struct CareerAssessmentResultHeroCardView: View {
    var title: String = "Analyst - Tech"
    var subtitle: String = "You thrive at the intersection of creativity and logic, turning complex problems into delightful, human centered solution"
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.baseWhite)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.baseWhite.opacity(0.85))
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 60)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
            
            Image(systemName: "briefcase.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 84, height: 84)
                .foregroundStyle(.baseWhite.opacity(0.18))
                .padding(.trailing, 16)
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [.bgPrimary, .bgDarkPrimary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CareerAssessmentResultHeroCardView()
        .padding()
}
