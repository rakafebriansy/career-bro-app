import SwiftUI

struct TokenBalanceHeroCardView: View {
    var remainingTokens: Int = 4250
    var totalQuota: Int = 5000
    var onClaimDaily: (() -> Void)? = nil
    var onTopUp: (() -> Void)? = nil
    
    private var progressRatio: Double {
        guard totalQuota > 0 else { return 0 }
        return min(max(Double(remainingTokens) / Double(totalQuota), 0.0), 1.0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Available AI Tokens")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.baseWhite.opacity(0.85))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text("\(remainingTokens)")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundStyle(.baseWhite)
                        
                        Text("Tokens")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.baseWhite.opacity(0.9))
                    }
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(.baseWhite.opacity(0.15))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: "sparkles")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.baseWhite)
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(.baseWhite.opacity(0.2))
                            .frame(height: 8)
                        
                        Capsule()
                            .fill(.baseWhite)
                            .frame(width: geo.size.width * CGFloat(progressRatio), height: 8)
                    }
                }
                .frame(height: 8)
                
                HStack {
                    Text("\(Int(progressRatio * 100))% Quota Remaining")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(.baseWhite.opacity(0.85))
                    
                    Spacer()
                    
                    Text("\(remainingTokens) / \(totalQuota)")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.baseWhite.opacity(0.85))
                }
            }
            
            HStack(spacing: 12) {
                Button {
                    onClaimDaily?()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "gift.fill")
                            .font(.caption)
                        Text("Claim Daily +100")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.bgPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                
                Button {
                    onTopUp?()
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus.circle.fill")
                            .font(.caption)
                        Text("Top Up")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.baseWhite)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(.baseWhite.opacity(0.2))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(.baseWhite.opacity(0.35), lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [.bgPrimary, .bgDarkPrimary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(.baseWhite.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    TokenBalanceHeroCardView()
        .padding()
}
