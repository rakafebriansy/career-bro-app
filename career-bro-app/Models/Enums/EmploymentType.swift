//
//  EmploymentType.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import Foundation

enum EmploymentType: String, Codable, CaseIterable {
    case fullTime = "Full-Time"
    case contract = "Contract"
    case internship = "Internship"
    case freelance = "Freelance"
}
