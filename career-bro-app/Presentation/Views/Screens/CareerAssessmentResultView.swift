import SwiftUI

struct CareerAssessmentResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            topNavigationBar
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    CareerAssessmentResultHeroCardView()
                    
                    CareerAssessmentResultArchetypeCardView()
                    
                    CareerAssessmentResultRadarChartView()
                    
                    CareerAssessmentResultWorkPreferencesView()
                    
                    CareerAssessmentResultRoadmapView()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 36)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
    
    private var topNavigationBar: some View {
        HStack {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.textPrimary)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
            
            Spacer()
            
            Text("Your Career DNA")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            Spacer()
            
            ShareLink(
                item: "Here is my Career DNA result: Analyst - Tech (Casper archetype) on Career Bro!",
                subject: Text("My Career DNA"),
                message: Text("Check out my Career DNA result on Career Bro!")
            ) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.textPrimary)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.baseStroke, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationStack {
        CareerAssessmentResultView()
    }
}
