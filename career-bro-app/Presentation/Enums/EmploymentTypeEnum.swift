//
//  EmploymentTypeEnum.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

enum EmploymentTypeEnum: String, Codable, CaseIterable {
    case fullTime = "Full-Time"
    case contract = "Contract"
    case internship = "Internship"
    case freelance = "Freelance"
}
