//
//  LocalJobDataSource.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftData

protocol LocalJobDataSourceProtocol {
    func fetchApplications() throws -> [JobApplicationModel]
    func fetchApplication(byId id: UUID) throws -> JobApplicationModel?
    func insertApplication(_ application: JobApplicationModel) throws
    func deleteApplication(_ application: JobApplicationModel) throws
    func save() throws
}

final class LocalJobDataSource: LocalJobDataSourceProtocol {
    private let modelContext: ModelContext?
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = modelContext
    }
    
    func fetchApplications() throws -> [JobApplicationModel] {
        guard let context = modelContext else {
            return SwiftDataSeeder.makeSampleApplications()
        }
        let descriptor = FetchDescriptor<JobApplicationModel>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try context.fetch(descriptor)
    }
    
    func fetchApplication(byId id: UUID) throws -> JobApplicationModel? {
        guard let context = modelContext else {
            return SwiftDataSeeder.makeSampleApplications().first { $0.id == id }
        }
        let descriptor = FetchDescriptor<JobApplicationModel>(predicate: #Predicate { $0.id == id })
        return try context.fetch(descriptor).first
    }
    
    func insertApplication(_ application: JobApplicationModel) throws {
        modelContext?.insert(application)
        try save()
    }
    
    func deleteApplication(_ application: JobApplicationModel) throws {
        modelContext?.delete(application)
        try save()
    }
    
    func save() throws {
        try modelContext?.save()
    }
}
