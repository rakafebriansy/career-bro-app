//
//  AISuggestionCardView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 24/09/26.
//

import SwiftUI

struct AISuggestionCardView: View {
    let title: String
    let message: String
    
    init(
        title: String = "AI Suggestion",
        message: String = "Prepare a case study on design system work, it's listed as a key requirement"
    ) {
        self.title = title
        self.message = message
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 36, height: 36)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.blue)
                
                Text(message)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color.blue.opacity(0.85))
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer(minLength: 0)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hex: "EEECFE"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    AISuggestionCardView()
        .padding()
}
