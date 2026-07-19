//
//  Button+Extension.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 19/07/26.
//

import SwiftUI

extension View {
    func appButtonStyle(_ variant: ButtonVariant = .primary) -> some View {
        self.buttonStyle(AppButtonStyle(variant: variant))
    }
}
