//
//  JobInfoRowView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct JobInfoRowView: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.blue)
                .frame(width: 20, alignment: .center)

            Text(text)
                .font(.system(size: 14, weight: .regular))
                .foregroundStyle(Color.black.opacity(0.85))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 12) {
        JobInfoRowView(icon: "briefcase", text: "Fulltime")
        JobInfoRowView(icon: "laptopcomputer", text: "Hybrid")
        JobInfoRowView(icon: "graduationcap", text: "S1 Computer Science, Visual Communication, Art")
    }
    .padding()
}
