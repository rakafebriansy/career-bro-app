//
//  NavigationMenuCatalog.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation

struct NavigationMenuItem {
    let title: String
    let subtitle: String
    let category: SearchResultCategoryEnum
    let systemImage: String
    let badgeText: String?
    let badgeColorHex: String
    let destination: SearchNavigationDestination
    let keywords: [String]
}

final class NavigationMenuCatalog {
    static let items: [NavigationMenuItem] = [

        NavigationMenuItem(
            title: "Home & Pipeline Lamaran",
            subtitle: "Halaman dashboard karir, ringkasan metrik, & pipeline lamaran kerja",
            category: .navigation,
            systemImage: "house.fill",
            badgeText: "Tab Utama",
            badgeColorHex: "3B82F6",
            destination: .tab(index: 0),
            keywords: ["home", "beranda", "dashboard", "summary", "ringkasan", "insight", "upcoming", "status", "lamaran", "pipeline", "kanban"]
        ),
        NavigationMenuItem(
            title: "Pencarian Universal (Search)",
            subtitle: "Cari seluruh menu, lamaran, template email, chat AI, & DNA karir",
            category: .navigation,
            systemImage: "magnifyingglass",
            badgeText: "Tab Search",
            badgeColorHex: "2563EB",
            destination: .tab(index: 1),
            keywords: ["search", "cari", "spotlight", "universal", "menu", "navigasi", "temukan"]
        ),
        NavigationMenuItem(
            title: "Robo AI Chatbot",
            subtitle: "Konsultasi karir, simulasi wawancara & ulasan resume AI",
            category: .navigation,
            systemImage: "sparkles",
            badgeText: "AI Assistant",
            badgeColorHex: "8B5CF6",
            destination: .tab(index: 2),
            keywords: ["robo", "chat", "ai", "bot", "tanya", "konsultasi", "simulasi", "review", "interviewer"]
        ),
        NavigationMenuItem(
            title: "Career DNA Roadmap",
            subtitle: "Peta potensi diri, arketipe karir & rekomendasi peran",
            category: .navigation,
            systemImage: "map.fill",
            badgeText: "Analisis",
            badgeColorHex: "10B981",
            destination: .tab(index: 3),
            keywords: ["career dna", "peta", "roadmap", "potensi", "radar", "arketipe", "rekomendasi"]
        ),
        NavigationMenuItem(
            title: "Profil & Pengaturan",
            subtitle: "Kelola akun pengguna, token saldo, dan preferensi aplikasi",
            category: .navigation,
            systemImage: "person.fill",
            badgeText: "Akun",
            badgeColorHex: "6B7280",
            destination: .tab(index: 4),
            keywords: ["profile", "profil", "pengaturan", "settings", "akun", "nama", "email", "notifikasi"]
        ),

        NavigationMenuItem(
            title: "Career Assessment Test",
            subtitle: "Ikuti tes kepribadian & minat karir untuk temukan Career DNA",
            category: .careerDNA,
            systemImage: "list.clipboard.fill",
            badgeText: "Tes Asesmen",
            badgeColorHex: "059669",
            destination: .careerAssessment,
            keywords: ["asesmen", "test", "kuis", "soal", "pertanyaan", "minat", "bakat", "analisis"]
        ),
        NavigationMenuItem(
            title: "Salary Predictor",
            subtitle: "Prediksi rentang gaji berdasarkan posisi & pengalaman",
            category: .navigation,
            systemImage: "dollarsign.circle.fill",
            badgeText: "Kalkulator",
            badgeColorHex: "F59E0B",
            destination: .salaryPredictor,
            keywords: ["salary", "gaji", "penghasilan", "kalkulator", "prediksi", "upah", "standar"]
        ),
        NavigationMenuItem(
            title: "CV & Resume Review",
            subtitle: "Evaluasi resume profesional dengan analisis kata kunci ATS",
            category: .navigation,
            systemImage: "doc.text.magnifyingglass",
            badgeText: "ATS Scanner",
            badgeColorHex: "EC4899",
            destination: .cvReview,
            keywords: ["cv", "resume", "review", "ats", "portfolio", "portofolio", "evaluasi"]
        ),
        NavigationMenuItem(
            title: "Email Template Center",
            subtitle: "Koleksi template surat lamaran, cold email, & follow-up",
            category: .emails,
            systemImage: "envelope.badge.fill",
            badgeText: "Template",
            badgeColorHex: "6366F1",
            destination: .emailDetail(id: UUID(), title: "Template Center"),
            keywords: ["email", "surat", "template", "follow up", "cold email", "cover letter", "hr"]
        ),
        NavigationMenuItem(
            title: "Riwayat Transaksi Token",
            subtitle: "Cek pemakaian dan saldo kuota AI token harian",
            category: .settings,
            systemImage: "clock.arrow.circlepath",
            badgeText: "Token",
            badgeColorHex: "F97316",
            destination: .tokenHistory,
            keywords: ["token", "saldo", "kuota", "transaksi", "kredit", "riwayat", "history", "penggunaan"]
        ),
        NavigationMenuItem(
            title: "Upgrade Paket & Top Up Token",
            subtitle: "Beli paket token ekstra atau hubungkan Custom API Key",
            category: .settings,
            systemImage: "star.fill",
            badgeText: "Premium",
            badgeColorHex: "EAB308",
            destination: .upgradePlan,
            keywords: ["upgrade", "top up", "beli", "paket", "premium", "api key", "gemini", "openai"]
        ),

        NavigationMenuItem(
            title: "Simulasi Wawancara HR",
            subtitle: "Latihan tanya jawab wawancara perilaku & budaya kerja",
            category: .chats,
            systemImage: "person.wave.2.fill",
            badgeText: "Simulasi",
            badgeColorHex: "8B5CF6",
            destination: .roboChat(initialPrompt: "Saya ingin latihan interview dengan HR untuk posisi Product Designer"),
            keywords: ["interview hr", "wawancara hr", "pertanyaan hr", "behavioral interview", "latihan"]
        ),
        NavigationMenuItem(
            title: "Simulasi Wawancara Tech Lead",
            subtitle: "Latihan wawancara teknis, arsitektur & pemecahan masalah",
            category: .chats,
            systemImage: "chevron.left.forwardslash.chevron.right",
            badgeText: "Simulasi",
            badgeColorHex: "3B82F6",
            destination: .roboChat(initialPrompt: "Saya ingin latihan interview teknis dengan Tech Lead"),
            keywords: ["interview tech lead", "wawancara teknis", "coding", "arsitektur", "tech lead"]
        ),
        NavigationMenuItem(
            title: "Reset Database SwiftData",
            subtitle: "Hapus dan pulihkan seluruh data default lokal aplikasi",
            category: .settings,
            systemImage: "arrow.counterclockwise.circle.fill",
            badgeText: "Pengembang",
            badgeColorHex: "EF4444",
            destination: .resetData,
            keywords: ["reset", "hapus data", "database", "swiftdata", "seeder", "default", "factory reset"]
        )
    ]
}
