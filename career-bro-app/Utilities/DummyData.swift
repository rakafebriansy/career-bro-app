//
//  DummyData.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import Foundation
import SwiftUI

extension JourneySummaryModel {
    static var dummyData: [JourneySummaryModel] {
        return [
            JourneySummaryModel(title: "To Apply", value: 30, color: Color(hex: "8E5CA6")), // Muted Purple
            JourneySummaryModel(title: "Screening", value: 20, color: Color(hex: "2E9D7E")), // Mint Green
            JourneySummaryModel(title: "Assessment", value: 25, color: Color(hex: "D9A21B")), // Mustard Yellow
            JourneySummaryModel(title: "Interview", value: 15, color: Color(hex: "F27F1B")), // Warm Orange
            JourneySummaryModel(title: "Offer", value: 10, color: Color(hex: "68BF30"))  // Lime Green
        ]
    }
}

extension JobApplicationModel {
    static var dummyData: [JobApplicationModel] {
        let now = Date()
        let calendar = Calendar.current
        
        return [
            // 1. Status: Applied -> Menunggu Pengumuman (Tinggal 3 hari lagi)
            JobApplicationModel(
                company: "Tokopedia",
                position: "iOS Engineer",
                status: .applied,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -2, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -2, to: now)!,
                announcementDate: calendar.date(byAdding: .day, value: 3, to: now)!,
                salaryMin: 15_000_000,
                salaryMax: 22_000_000,
                currency: "IDR"
            ),
            
            // 2. Status: Interview -> Jadwal Interview besok
            JobApplicationModel(
                company: "Gojek",
                position: "Associate Product Manager",
                status: .interview,
                workLocation: .hybrid,
                employment: .fullTime,
                priority: .high, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -10, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -1, to: now)!,
                dateInterview: calendar.date(byAdding: .day, value: 1, to: now)!,
                salaryMin: 18_000_000,
                salaryMax: 25_000_000,
                currency: "IDR"
            ),
            
            // 3. Status: Offered -> Tahap akhir (Tidak butuh deadline)
            JobApplicationModel(
                company: "Traveloka",
                position: "Data Analyst Intern",
                status: .offered,
                workLocation: .remote,
                employment: .internship,
                priority: .medium, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -14, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -2, to: now)!,
                salaryMin: 5_000_000,
                salaryMax: 7_500_000,
                currency: "IDR"
            ),
            
            // 4. Status: Accepted -> Tahap akhir
            JobApplicationModel(
                company: "Bukalapak",
                position: "Senior QA Automation",
                status: .accepted,
                workLocation: .hybrid,
                employment: .contract,
                priority: .low, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -20, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -5, to: now)!,
                salaryMin: 12_000_000,
                salaryMax: 17_000_000,
                currency: "IDR"
            ),
            
            // 5. Status: Rejected -> Tahap akhir
            JobApplicationModel(
                company: "Sea Group",
                position: "Backend Engineer (Golang)",
                status: .rejected,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -30, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -12, to: now)!,
                salaryMin: 5000,
                salaryMax: 7500,
                currency: "SGD"
            ),
            
            // 6. Status: Need To Apply -> Punya Due Date 5 hari ke depan
            JobApplicationModel(
                company: "Blibli",
                position: "UI/UX Designer",
                status: .needToApply,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low, // ⬅️ Dipindah ke sini
                createdAt: now,
                updatedAt: now,
                dueDate: calendar.date(byAdding: .day, value: 5, to: now)!,
                salaryMin: 8_000_000,
                salaryMax: 12_000_000,
                currency: "IDR"
            ),
            
            // 7. Status: Post-Interview -> Menunggu hasil interview minggu depan
            JobApplicationModel(
                company: "Stripe",
                position: "Solutions Architect",
                status: .postInterview,
                workLocation: .remote,
                employment: .fullTime,
                priority: .low, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -15, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -3, to: now)!,
                interviewAnnouncementDate: calendar.date(byAdding: .day, value: 7, to: now)!,
                salaryMin: 8000,
                salaryMax: 11000,
                currency: "USD"
            ),
            
            // 8. Status: Assessment -> Jadwal tes 2 hari lagi
            JobApplicationModel(
                company: "Bank Mandiri",
                position: "Officer Development Program (ODP) IT",
                status: .assessment,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -1, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -1, to: now)!,
                dateAssessment: calendar.date(byAdding: .day, value: 2, to: now)!,
                currency: "IDR"
            ),
            
            // 9. Status: Ghosted -> Sudah lama lewat (Expired case)
            JobApplicationModel(
                company: "Tiket.com",
                position: "DevOps Engineer",
                status: .ghosted,
                workLocation: .hybrid,
                employment: .fullTime,
                priority: .high, // ⬅️ Dipindah ke sini
                createdAt: calendar.date(byAdding: .day, value: -45, to: now)!,
                updatedAt: calendar.date(byAdding: .day, value: -45, to: now)!,
                salaryMin: 16_000_000,
                salaryMax: 24_000_000,
                currency: "IDR"
            )
        ]
    }
}
