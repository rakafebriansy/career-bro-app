//
//  CareerAssessmentResultRadarChartView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerAssessmentResultRadarChartView: View {
    struct TraitScore: Identifiable {
        let id = UUID()
        let name: String
        let code: String
        let score: Int
        let maxScore: Int

        var normalized: Double {
            Double(score) / Double(maxScore)
        }
    }

    var traits: [TraitScore] = [
        TraitScore(name: "Deep Thinking", code: "DT", score: 85, maxScore: 100),
        TraitScore(name: "Deep Thinking", code: "DT", score: 75, maxScore: 100),
        TraitScore(name: "Visual Thinking", code: "VS", score: 92, maxScore: 100),
        TraitScore(name: "Deep Thinking", code: "DT", score: 80, maxScore: 100),
        TraitScore(name: "Deep Thinking", code: "DT", score: 70, maxScore: 100)
    ]

    var body: some View {
        VStack(spacing: 24) {
            radarCanvas
                .frame(height: 200)
                .padding(.top, 8)

            traitBreakdownGrid
        }
        .frame(maxWidth: .infinity)
    }

    private var radarCanvas: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) * 0.38
            let count = max(traits.count, 5)

            ZStack {
                ForEach(1...4, id: \.self) { ring in
                    let ringRadius = radius * (CGFloat(ring) / 4.0)
                    PentagonPolygonShape(sides: count, radius: ringRadius, center: center)
                        .stroke(Color.bgPrimary.opacity(0.3), lineWidth: 1)
                }

                ForEach(0..<count, id: \.self) { index in
                    let angle = angleForIndex(index, count: count)
                    let endPoint = pointOnCircle(center: center, radius: radius, angle: angle)

                    Path { path in
                        path.move(to: center)
                        path.addLine(to: endPoint)
                    }
                    .stroke(Color.bgPrimary.opacity(0.3), lineWidth: 1)

                    let labelPoint = pointOnCircle(center: center, radius: radius + 16, angle: angle)
                    let code = index < traits.count ? traits[index].code : "DT"
                    Text(code)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.baseText)
                        .position(labelPoint)
                }

                RadarDataShape(
                    values: traits.map { $0.normalized },
                    maxRadius: radius,
                    center: center
                )
                .fill(
                    LinearGradient(
                        colors: [Color.bgPrimary.opacity(0.7), Color(hex: "#60A5FA").opacity(0.5)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                RadarDataShape(
                    values: traits.map { $0.normalized },
                    maxRadius: radius,
                    center: center
                )
                .stroke(Color.bgPrimary, lineWidth: 2)
            }
        }
    }

    private var traitBreakdownGrid: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(spacing: 14) {
                traitProgressBar(label: "Visual Thinking (VS)", value: 92)
                traitProgressBar(label: "Visual Thinking (VS)", value: 92)
                traitProgressBar(label: "Visual Thinking (VS)", value: 92)
            }
            .frame(maxWidth: .infinity)

            VStack(spacing: 14) {
                traitProgressBar(label: "Deep Thinking (DT)", value: 92)
                traitProgressBar(label: "Deep Thinking (DT)", value: 92)
            }
            .frame(maxWidth: .infinity)
        }
    }

    private func traitProgressBar(label: String, value: Int) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(label)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.textPrimary)

                Spacer()

                Text("\(value)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#737373"))
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.baseStroke.opacity(0.5))
                        .frame(height: 5)

                    Capsule()
                        .fill(Color.bgPrimary)
                        .frame(width: geo.size.width * CGFloat(value) / 100.0, height: 5)
                }
            }
            .frame(height: 5)
        }
    }

    private func angleForIndex(_ index: Int, count: Int) -> Double {
        let step = (2.0 * .pi) / Double(count)
        return -Double.pi / 2.0 + step * Double(index)
    }

    private func pointOnCircle(center: CGPoint, radius: CGFloat, angle: Double) -> CGPoint {
        CGPoint(
            x: center.x + radius * CGFloat(cos(angle)),
            y: center.y + radius * CGFloat(sin(angle))
        )
    }
}

private struct PentagonPolygonShape: Shape {
    let sides: Int
    let radius: CGFloat
    let center: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard sides >= 3 else { return path }

        let step = (2.0 * .pi) / Double(sides)
        let initialAngle = -Double.pi / 2.0

        for i in 0..<sides {
            let angle = initialAngle + step * Double(i)
            let pt = CGPoint(
                x: center.x + radius * CGFloat(cos(angle)),
                y: center.y + radius * CGFloat(sin(angle))
            )
            if i == 0 {
                path.move(to: pt)
            } else {
                path.addLine(to: pt)
            }
        }
        path.closeSubpath()
        return path
    }
}

private struct RadarDataShape: Shape {
    let values: [Double]
    let maxRadius: CGFloat
    let center: CGPoint

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard !values.isEmpty else { return path }

        let count = values.count
        let step = (2.0 * .pi) / Double(count)
        let initialAngle = -Double.pi / 2.0

        for i in 0..<count {
            let angle = initialAngle + step * Double(i)
            let r = maxRadius * CGFloat(values[i])
            let pt = CGPoint(
                x: center.x + r * CGFloat(cos(angle)),
                y: center.y + r * CGFloat(sin(angle))
            )
            if i == 0 {
                path.move(to: pt)
            } else {
                path.addLine(to: pt)
            }
        }
        path.closeSubpath()
        return path
    }
}

#Preview {
    CareerAssessmentResultRadarChartView()
        .padding()
}
