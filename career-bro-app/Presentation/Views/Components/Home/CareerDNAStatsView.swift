import SwiftUI

struct CareerDNAStatsView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                VStack (alignment: .leading) {
                    Text("Analyst - Tech")
                        .foregroundStyle(.baseWhite)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Text("You thrive at the intersection of creativity and logic, turning complex problems into delightful human centered solution")
                        .foregroundStyle(Color(hex: "#D4D4D4"))
                        .font(.caption)
                }
                Spacer()
                Divider()
                    .frame(width: 0.5)
                        .background(Color(hex: "#D4D4D4"))
                Spacer()
                Text("Updated\n10 mins ago")
                    .foregroundStyle(Color(hex: "#D4D4D4"))
                    .font(.caption2)
                    .fontWeight(.light)
            }
            .padding()
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(colors: [.bgPrimary, .bgDarkPrimary], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .clipShape(
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 12,
                )
            )
            VStack (alignment: .leading) {
                Text("Your Strength")
                    .foregroundStyle(.baseText)
                    .font(.subheadline)
                    .fontWeight(.medium)
                ViewThatFits(in: .horizontal) {
                    HStack {
                        Badge("Deep Thinking", isOutlined: true)
                        Badge("Creative Thinking", isOutlined: true)
                        Badge("Problem Solving", isOutlined: true)
                    }
                    HStack {
                        Badge("Deep Thinking", isOutlined: true)
                        Badge("Creative Thinking", isOutlined: true)
                        Text("+1 more")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Badge("Deep Thinking", isOutlined: true)
                        Text("+2 more")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()
            Rectangle()
                .fill(Color(.baseStroke))
                .frame(height: 2)
            VStack (alignment: .leading, spacing: 6) {
                Text("Recommended Position")
                    .foregroundStyle(.baseText)
                    .font(.subheadline)
                    .fontWeight(.medium)
                HStack {
                    HStack {
                        Image(systemName: "briefcase")
                            .foregroundStyle(.bgPrimary)
                            .fontWeight(.bold)
                        Text("System Analyst")
                            .font(.subheadline)
                    }
                    Spacer()
                    Badge("96%", color: Color(hex: "E0F2FE"), textColor: .bgPrimary)
                }
            }
            .padding()
            Rectangle()
                .fill(Color(.baseStroke))
                .frame(height: 2)
            CareerMilestoneView()
                .padding()
            Button("View Full") {
            }
            .appButtonStyle()
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 20)
        }
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 12,
                bottomTrailingRadius: 12,
                topTrailingRadius: 0,
            )
        )
        .overlay(
            UnevenRoundedRectangle(topLeadingRadius: 0,
                                   bottomLeadingRadius: 12,
                                   bottomTrailingRadius: 12,
                                   topTrailingRadius: 0)
            .stroke(.baseStroke, lineWidth: 2)
                .padding(.top, -2)
        )
    }
}

struct CareerMilestoneView: View {
    var body: some View {
        HStack (alignment: .top) {
            CareerMilestoneNodeView(title: "Junior UI/UX Designer", level: "Junior", isLinked: true, isActive: true)
            CareerMilestoneNodeView(title: "Product Designer", level: "Middle", isLinked: true, isActive: true)
            CareerMilestoneNodeView(title: "Lead Designer", level: "Junior", isLinked: false, isActive: false)
        }
    }
}

struct CareerMilestoneNodeView: View {
    let title: String
    let level: String
    var isLinked: Bool = true
    var isActive: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: isActive ? "checkmark.circle.fill" : "circle.grid.3x3.circle.fill")
                    .foregroundStyle(isActive ? .bgPrimary : Color(hex: "#CCCCCC"))
                    .frame(width: 20, height: 20)
                    .padding(2)
                    .overlay(
                        Circle()
                            .stroke(isActive ? .bgPrimary : Color(hex: "#CCCCCC"), lineWidth: 2)
                    )
                if isLinked {
                    Rectangle()
                        .fill(Color(hex: "#CCCCCC"))
                        .frame(height: 2)
                }
            }
            Text(level)
                .foregroundStyle(Color(hex: "#A8AABC"))
                .font(.caption)
            Text(title)
                .font(.caption)
        }
    }
}

#Preview {
    CareerDNAStatsView()
}
