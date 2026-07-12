//
//  Date+Extension.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 12/07/26.
//

import Foundation

extension Date {
    private static let sharedDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    private static let sharedTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    func toFormattedDate() -> String {
        return Self.sharedDateFormatter.string(from: self)
    }
    
    func toFormattedDatetime() -> String {
        let dateString = Self.sharedDateFormatter.string(from: self)
        let timeString = Self.sharedTimeFormatter.string(from: self)
        return "\(dateString) | \(timeString)"
    }
}
