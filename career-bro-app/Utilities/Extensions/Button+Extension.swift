//
//  Button+Extension.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

extension View {
    func appButtonStyle(_ variant: ButtonVariantEnum = .primary) -> some View {
        self.buttonStyle(AppButtonStyle(variant: variant))
    }
}
