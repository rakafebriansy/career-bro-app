//
//  CareerAssessmentProgressBarView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentProgressBarView: View {
    var current: Int = 5
    var total: Int = 25
    
    var body: some View {
        HStack(spacing: 12) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(hex: "#F1F5F9"))
                        .frame(height: 8)
                    
                    let progress = total > 0 ? min(max(CGFloat(current) / CGFloat(total), 0.0), 1.0) : 0.0
                    Capsule()
                        .fill(Color.bgPrimary)
                        .frame(width: geometry.size.width * progress, height: 8)
                }
            }
            .frame(height: 8)
            
            Text("\(current)/\(total)")
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(Color(hex: "#8E8E93"))
        }
    }
}

#Preview {
    CareerAssessmentProgressBarView(current: 5, total: 25)
        .padding()
}
