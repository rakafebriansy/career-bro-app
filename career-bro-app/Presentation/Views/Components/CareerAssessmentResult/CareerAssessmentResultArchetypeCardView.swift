//
//  CareerAssessmentResultArchetypeCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentResultArchetypeCardView: View {
    var archetype: String = "Casper"
    var description: String = "Casper is a person that have their own space to think about everything. They could questioning about benefit, risk, goals, and what they could in the future"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("You Are..")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            HStack(alignment: .top, spacing: 16) {
                casperMascotView
                    .frame(width: 58, height: 58)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(archetype)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.bgPrimary)
                    
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.baseText)
                        .lineSpacing(2)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
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
    
    private var casperMascotView: some View {
        ZStack {
            CasperGhostBodyShape()
                .fill(
                    LinearGradient(
                        colors: [Color(hex: "#60A5FA"), Color(hex: "#3B82F6")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                        .overlay(
                            Circle()
                                .fill(Color.black)
                                .frame(width: 4, height: 4)
                        )
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 8, height: 8)
                        .overlay(
                            Circle()
                                .fill(Color.black)
                                .frame(width: 4, height: 4)
                        )
                }
                
                Capsule()
                    .fill(Color.black.opacity(0.85))
                    .frame(width: 10, height: 3)
            }
            .offset(y: -2)
        }
    }
}

private struct CasperGhostBodyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        path.move(to: CGPoint(x: 0, y: h * 0.45))
        path.addCurve(
            to: CGPoint(x: w, y: h * 0.45),
            control1: CGPoint(x: 0, y: -h * 0.08),
            control2: CGPoint(x: w, y: -h * 0.08)
        )
        path.addLine(to: CGPoint(x: w, y: h * 0.85))
        
        let ripples = 3
        let rippleW = w / CGFloat(ripples)
        for i in 0..<ripples {
            let startX = w - CGFloat(i) * rippleW
            let endX = w - CGFloat(i + 1) * rippleW
            let midX = (startX + endX) / 2
            path.addQuadCurve(
                to: CGPoint(x: endX, y: h * 0.85),
                control: CGPoint(x: midX, y: h * 1.05)
            )
        }
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    CareerAssessmentResultArchetypeCardView()
        .padding()
}
