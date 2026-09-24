//
//  JourneySummaryModel.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import Foundation
import SwiftUI

struct JourneySummaryModel: Identifiable {
    let id = UUID()
    let title: String
    let value: Int
    let color: Color
}
