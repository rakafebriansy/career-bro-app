//
//  EmailPlaceholderChipsToolbarView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct EmailPlaceholderChipsToolbarView: View {
    var onInsertPlaceholder: ((String) -> Void)? = nil
    
    let placeholders = [
        "[Company Name]",
        "[Job Title]",
        "[Your Name]",
        "[Portfolio URL]",
        "[Application Date]",
        "[Hiring Manager]"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: "curlybraces")
                    .font(.caption2)
                    .foregroundStyle(Color.bgPrimary)
                
                Text("Insert Dynamic Variable")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color(hex: "#737373"))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(placeholders, id: \.self) { token in
                        Button {
                            onInsertPlaceholder?(token)
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "plus")
                                    .font(.system(size: 9, weight: .bold))
                                Text(token)
                                    .font(.system(size: 11, weight: .semibold))
                            }
                            .foregroundStyle(Color.bgPrimary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(hex: "#EFF6FF"))
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.bgPrimary.opacity(0.3), lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

#Preview {
    EmailPlaceholderChipsToolbarView()
        .padding()
}
