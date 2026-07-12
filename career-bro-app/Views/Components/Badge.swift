//
//  Badge.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 12/07/26.
//

import SwiftUI

struct Badge: View {
    let text: String
    let color: Color
    let textColor: Color
    let isOutlined: Bool
    
    init(
        _ text: String,
        color: Color = .blue,
        textColor: Color = .white,
        isOutlined: Bool = false
    ) {
        self.text = text
        self.color = color
        self.textColor = textColor
        self.isOutlined = isOutlined
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(isOutlined ? color : textColor)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Group {
                    if isOutlined {
                        Capsule()
                            .stroke(color, lineWidth: 1)
                    } else {
                        Capsule()
                            .fill(color)
                    }
                }
            )
    }
}

#Preview {
    Badge("Hello", color: .red)
}
