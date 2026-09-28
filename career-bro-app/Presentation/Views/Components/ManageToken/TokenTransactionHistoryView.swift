import SwiftUI

struct TokenTransactionHistoryView: View {
    struct TokenTransactionItem: Identifiable {
        let id = UUID()
        let title: String
        let dateString: String
        let tokenDelta: Int
        let iconName: String
    }
    
    var transactions: [TokenTransactionItem] = [
        TokenTransactionItem(
            title: "Daily Login Bonus",
            dateString: "Today, 08:30 AM",
            tokenDelta: 100,
            iconName: "gift.fill"
        ),
        TokenTransactionItem(
            title: "AI Chatbot Mock Interview",
            dateString: "Yesterday, 03:15 PM",
            tokenDelta: -35,
            iconName: "bubble.left.and.bubble.right.fill"
        ),
        TokenTransactionItem(
            title: "Resume / CV AI Scan",
            dateString: "25 Sep, 10:20 AM",
            tokenDelta: -50,
            iconName: "doc.text.magnifyingglass"
        ),
        TokenTransactionItem(
            title: "Starter Pack Top Up",
            dateString: "22 Sep, 02:40 PM",
            tokenDelta: 1000,
            iconName: "plus.circle.fill"
        )
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Recent Token Activity")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)
            
            VStack(spacing: 0) {
                ForEach(Array(transactions.enumerated()), id: \.element.id) { index, item in
                    transactionRow(item: item)
                    
                    if index < transactions.count - 1 {
                        Divider()
                            .foregroundStyle(Color.baseStroke)
                            .padding(.leading, 56)
                    }
                }
            }
            .padding(14)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.baseStroke, lineWidth: 1)
            )
        }
    }
    
    private func transactionRow(item: TokenTransactionItem) -> some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(item.tokenDelta > 0 ? Color(hex: "#F0FDF4") : Color(hex: "#F1F5F9"))
                    .frame(width: 38, height: 38)
                
                Image(systemName: item.iconName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(item.tokenDelta > 0 ? Color(hex: "#16A34A") : Color(hex: "#4B5563"))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.textPrimary)
                
                Text(item.dateString)
                    .font(.caption2)
                    .foregroundStyle(Color(hex: "#737373"))
            }
            
            Spacer()
            
            Text(item.tokenDelta > 0 ? "+\(item.tokenDelta)" : "\(item.tokenDelta)")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(item.tokenDelta > 0 ? Color(hex: "#16A34A") : .textPrimary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TokenTransactionHistoryView()
        .padding()
}
