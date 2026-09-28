//
//  JourneySummaryModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI

struct JourneySummaryModel: Identifiable {
    let id = UUID()
    let title: String
    let value: Int
    let color: Color
}
