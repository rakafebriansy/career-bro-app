//
//  SwiftDataSeeder.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import Foundation
import SwiftUI
import SwiftData

struct SwiftDataSeeder {
    @MainActor
    static let previewContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: JobApplicationModel.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            seedIfNeeded(context: container.mainContext)
            return container
        } catch {
            fatalError("Failed to initialize preview ModelContainer: \(error.localizedDescription)")
        }
    }()
    
    @MainActor
    static func seedIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<JobApplicationModel>()
        let count = (try? context.fetchCount(descriptor)) ?? 0
        if count == 0 {
            for app in makeSampleApplications() {
                context.insert(app)
            }
            try? context.save()
        }
    }
    
    @MainActor
    static func resetAndReseed(context: ModelContext) {
        let descriptor = FetchDescriptor<JobApplicationModel>()
        if let existing = try? context.fetch(descriptor) {
            for app in existing {
                context.delete(app)
            }
            try? context.save()
        }
        for app in makeSampleApplications() {
            context.insert(app)
        }
        try? context.save()
    }
    
    @MainActor
    static func fetchFirstSample(context: ModelContext) -> JobApplicationModel {
        let descriptor = FetchDescriptor<JobApplicationModel>()
        if let first = try? context.fetch(descriptor).first {
            return first
        }
        let fallback = makeSampleApplications()[0]
        context.insert(fallback)
        return fallback
    }
    
    static func computeJourneySummary(from applications: [JobApplicationModel]) -> [JourneySummaryModel] {
        let toApplyCount = applications.filter { $0.status == .needToApply }.count
        let appliedCount = applications.filter { $0.status == .applied }.count
        let assessmentCount = applications.filter { $0.status == .assessment }.count
        let interviewCount = applications.filter { $0.status == .interview || $0.status == .postInterview }.count
        let offerCount = applications.filter { $0.status == .offered || $0.status == .accepted }.count
        
        return [
            JourneySummaryModel(title: "To Apply", value: toApplyCount, color: Color(hex: "8E5CA6")),
            JourneySummaryModel(title: "Screening", value: appliedCount, color: Color(hex: "2E9D7E")),
            JourneySummaryModel(title: "Assessment", value: assessmentCount, color: Color(hex: "D9A21B")),
            JourneySummaryModel(title: "Interview", value: interviewCount, color: Color(hex: "F27F1B")),
            JourneySummaryModel(title: "Offer", value: offerCount, color: Color(hex: "68BF30"))
        ]
    }
    
    static func makeSampleApplications() -> [JobApplicationModel] {
        let now = Date()
        let calendar = Calendar.current
        
        return [
            JobApplicationModel(
                company: "Tokopedia",
                position: "iOS Engineer",
                status: .applied,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low,
                createdAt: calendar.date(byAdding: .day, value: -2, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -2, to: now) ?? now,
                announcementDate: calendar.date(byAdding: .day, value: 3, to: now),
                salaryMin: 15_000_000,
                salaryMax: 22_000_000,
                currency: "IDR",
                location: "Kuningan, Jakarta Selatan",
                jobDescription: "Join our Core Mobile Team to build high-performance e-commerce iOS features used by millions of users daily. You will collaborate with cross-functional teams to engineer delightful consumer experiences.",
                requirements: [
                    "S1 Computer Science, Information Technology, or related field",
                    "3+ years professional iOS development with Swift & SwiftUI",
                    "Deep understanding of Combine, MVVM, and Modular Architecture",
                    "Published portfolio apps on the App Store"
                ],
                keywords: [
                    "Swift",
                    "SwiftUI",
                    "Combine",
                    "Modularization",
                    "Clean Architecture"
                ],
                aiSuggestion: "Highlight your SwiftUI architecture knowledge and memory management best practices during technical discussions.",
                jobUrl: "tokopedia.com/careers/ios-engineer-2026",
                attachments: [
                    "Resume_Raka.pdf",
                    "Portfolio_iOS_2026.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Gojek",
                position: "Associate Product Manager",
                status: .interview,
                workLocation: .hybrid,
                employment: .fullTime,
                priority: .high,
                createdAt: calendar.date(byAdding: .day, value: -10, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                dateInterview: calendar.date(byAdding: .day, value: 1, to: now),
                salaryMin: 18_000_000,
                salaryMax: 25_000_000,
                currency: "IDR",
                location: "Pasaraya Blok M, Jakarta Selatan",
                jobDescription: "Drive product strategy, experimentation, and execution across on-demand transport and logistic verticals to enhance rider experience and conversion funnels.",
                requirements: [
                    "Bachelor's degree in Engineering, Business, or Computer Science",
                    "1-2 years experience in product management or data analytics",
                    "Strong proficiency in SQL, metric tree decomposition, and A/B testing",
                    "Demonstrated structured problem-solving through product case studies"
                ],
                keywords: [
                    "Product Strategy",
                    "Data Analytics",
                    "SQL",
                    "A/B Testing",
                    "Agile"
                ],
                aiSuggestion: "Review your marketplace dynamic pricing framework and prepare customer journey metrics for the stakeholder interview.",
                jobUrl: "gojek.io/careers/apm-growth",
                attachments: [
                    "APM_CaseStudy_Gojek.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Traveloka",
                position: "Data Analyst Intern",
                status: .offered,
                workLocation: .remote,
                employment: .internship,
                priority: .medium,
                createdAt: calendar.date(byAdding: .day, value: -14, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -2, to: now) ?? now,
                salaryMin: 5_000_000,
                salaryMax: 7_500_000,
                currency: "IDR",
                location: "BSD City, Tangerang",
                jobDescription: "Perform cohort and exploratory data analysis across flight and accommodation booking funnels to discover revenue optimization opportunities.",
                requirements: [
                    "Final year undergraduate student or fresh graduate in Statistics/CS",
                    "Strong command of SQL, Python (Pandas, NumPy), and data visualization",
                    "Experience creating dashboards with Tableau or Looker Studio",
                    "Curiosity and passion for travel-tech business intelligence"
                ],
                keywords: [
                    "Python",
                    "SQL",
                    "Tableau",
                    "Cohort Analysis",
                    "Statistics"
                ],
                aiSuggestion: "Prepare questions about full-time conversion pathways before signing the offer acceptance form.",
                jobUrl: "traveloka.com/careers/data-analyst-intern",
                attachments: [
                    "Offer_Letter_Traveloka.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Bukalapak",
                position: "Senior QA Automation",
                status: .accepted,
                workLocation: .hybrid,
                employment: .contract,
                priority: .low,
                createdAt: calendar.date(byAdding: .day, value: -20, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -5, to: now) ?? now,
                salaryMin: 12_000_000,
                salaryMax: 17_000_000,
                currency: "IDR",
                location: "Cilandak, Jakarta Selatan",
                jobDescription: "Lead end-to-end automation test suite reliability across iOS and Android apps, integrating automated regression suites into CI/CD build pipelines.",
                requirements: [
                    "4+ years in software quality engineering and automation",
                    "Hands-on expertise with Appium, XCUITest, and Cypress",
                    "Proficiency in setting up CI/CD workflows with GitHub Actions",
                    "Strong background in API testing with Postman and REST Assured"
                ],
                keywords: [
                    "Appium",
                    "XCUITest",
                    "CI/CD",
                    "API Testing",
                    "Quality Assurance"
                ],
                aiSuggestion: "Review the team's testing documentation and prepare your development environment before Day 1.",
                jobUrl: "careers.bukalapak.com/qa-automation",
                attachments: [
                    "Signed_Contract_Bukalapak.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Sea Group",
                position: "Backend Engineer (Golang)",
                status: .rejected,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low,
                createdAt: calendar.date(byAdding: .day, value: -30, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -12, to: now) ?? now,
                salaryMin: 5000,
                salaryMax: 7500,
                currency: "SGD",
                location: "One North, Singapore",
                jobDescription: "Architect and scale high-throughput payment gateway microservices processing over 50k transactions per second across Southeast Asia.",
                requirements: [
                    "BSc or MSc in Computer Science or related STEM disciplines",
                    "3+ years experience with Golang, gRPC, and distributed microservices",
                    "Expertise in PostgreSQL, Redis caching, and Kafka message queues",
                    "Solid understanding of concurrency, memory management, and profiling"
                ],
                keywords: [
                    "Golang",
                    "gRPC",
                    "Kafka",
                    "PostgreSQL",
                    "Redis"
                ],
                aiSuggestion: "Review distributed system concurrency patterns and retry strategies for future interview cycles.",
                jobUrl: "careers.sea.com/sg/backend-golang",
                attachments: [
                    "Sea_Interview_Notes.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Blibli",
                position: "UI/UX Designer",
                status: .needToApply,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low,
                createdAt: now,
                updatedAt: now,
                dueDate: calendar.date(byAdding: .day, value: 5, to: now),
                salaryMin: 8_000_000,
                salaryMax: 12_000_000,
                currency: "IDR",
                location: "Slipi, Jakarta Barat",
                jobDescription: "Craft intuitive mobile checkout and omnichannel loyalty reward experiences for Blibli consumers across iOS and Android apps.",
                requirements: [
                    "S1 Visual Communication Design, UI/UX, or related fields",
                    "2+ years experience designing mobile consumer applications",
                    "Proficiency in Figma components, auto-layout, and prototyping",
                    "Strong portfolio demonstrating end-to-end user-centered design"
                ],
                keywords: [
                    "Figma",
                    "Design System",
                    "User Research",
                    "Prototyping",
                    "Wireframing"
                ],
                aiSuggestion: "Tailor your portfolio case study with before-and-after conversion rate improvements.",
                jobUrl: "blibli.com/careers/uiux-designer",
                attachments: [
                    "Blibli_Job_Spec.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Stripe",
                position: "Solutions Architect",
                status: .postInterview,
                workLocation: .remote,
                employment: .fullTime,
                priority: .low,
                createdAt: calendar.date(byAdding: .day, value: -15, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -3, to: now) ?? now,
                interviewAnnouncementDate: calendar.date(byAdding: .day, value: 7, to: now),
                salaryMin: 8000,
                salaryMax: 11000,
                currency: "USD",
                location: "Remote (Global / APAC)",
                jobDescription: "Partner with strategic high-growth technology enterprises to design robust, compliant, and scalable global financial infrastructure on Stripe.",
                requirements: [
                    "5+ years in enterprise solutions architecture or technical consulting",
                    "Deep knowledge of RESTful APIs, webhooks, and payment protocols",
                    "Proven ability to lead technical whiteboarding sessions with CTOs and VPs",
                    "Strong software engineering background in modern backend tech stacks"
                ],
                keywords: [
                    "APIs",
                    "Fintech",
                    "Cloud Architecture",
                    "System Design",
                    "Solutions"
                ],
                aiSuggestion: "Send a polite follow-up note summarizing key architectural decisions discussed during the partner interview.",
                jobUrl: "stripe.com/jobs/solutions-architect-apac",
                attachments: [
                    "Stripe_Technical_Deck.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Bank Mandiri",
                position: "Officer Development Program (ODP) IT",
                status: .assessment,
                workLocation: .onsite,
                employment: .fullTime,
                priority: .low,
                createdAt: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                dateAssessment: calendar.date(byAdding: .day, value: 2, to: now),
                salaryMin: 10_000_000,
                salaryMax: 14_000_000,
                currency: "IDR",
                location: "Plaza Mandiri, Gatot Subroto, Jakarta",
                jobDescription: "Fast-track leadership development program designed to train future technology innovators and leaders across digital banking and cybersecurity domains.",
                requirements: [
                    "Bachelor's or Master's degree in IT/CS with minimum GPA 3.25",
                    "Solid foundation in algorithms, databases, and network security",
                    "Strong analytical thinking, leadership potential, and communication skills",
                    "Fluent in English both written and spoken"
                ],
                keywords: [
                    "Banking IT",
                    "Cybersecurity",
                    "Data Structure",
                    "Leadership",
                    "Fintech"
                ],
                aiSuggestion: "Practice numerical reasoning and core banking architecture case studies for the upcoming online test.",
                jobUrl: "mandiri.rekreasi.id/odp-it-2026",
                attachments: [
                    "Mandiri_Test_Confirmation.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Tiket.com",
                position: "DevOps Engineer",
                status: .ghosted,
                workLocation: .hybrid,
                employment: .fullTime,
                priority: .high,
                createdAt: calendar.date(byAdding: .day, value: -45, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -45, to: now) ?? now,
                salaryMin: 16_000_000,
                salaryMax: 24_000_000,
                currency: "IDR",
                location: "Kuningan, Jakarta Selatan",
                jobDescription: "Maintain high availability and resilience for multi-cloud Kubernetes clusters powering millions of travel booking transactions.",
                requirements: [
                    "3+ years managing production Kubernetes and infrastructure-as-code",
                    "Hands-on expertise with Terraform, AWS, GCP, and Ansible",
                    "Experience with Prometheus, Grafana, and ELK observability stacks",
                    "Strong scripting skills in Bash and Python"
                ],
                keywords: [
                    "Kubernetes",
                    "Terraform",
                    "AWS",
                    "Docker",
                    "CI/CD"
                ],
                aiSuggestion: "Send a polite final status check-in or archive this application to keep your pipeline tidy.",
                jobUrl: "tiket.com/careers/devops-engineer",
                attachments: [
                    "Tiket_Application.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Astra International",
                position: "System Analyst",
                status: .interview,
                workLocation: .hybrid,
                employment: .fullTime,
                priority: .high,
                createdAt: calendar.date(byAdding: .hour, value: -2, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .hour, value: -2, to: now) ?? now,
                dueDate: calendar.date(byAdding: .day, value: 4, to: now),
                dateInterview: calendar.date(byAdding: .day, value: 3, to: now),
                salaryMin: 7_000_000,
                salaryMax: 8_000_000,
                currency: "IDR",
                location: "Gading Serpong, Jakarta",
                jobDescription: "We are currently building a talent pool of candidates who would like to be considered for upcoming Data Annotator and Systems Engineering projects.",
                requirements: [
                    "S1 Computer Science, Visual Communication, Art",
                    "2+ years experience in systems architecture and requirements modeling",
                    "Experience with UML diagrams, system integration, and APIs",
                    "CV, portfolio"
                ],
                keywords: [
                    "Figma",
                    "Prototype",
                    "Auto Layout",
                    "Responsive"
                ],
                aiSuggestion: "Prepare a case study on design system work, it's listed as a key requirement.",
                jobUrl: "glints/aksdjbasjb/jdddsa.com",
                attachments: [
                    "flyer.jpg"
                ]
            ),
            
            JobApplicationModel(
                company: "DANA Indonesia",
                position: "Mobile iOS Architect",
                status: .needToApply,
                workLocation: .hybrid,
                employment: .fullTime,
                priority: .high,
                createdAt: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -1, to: now) ?? now,
                dueDate: calendar.date(byAdding: .day, value: 6, to: now),
                salaryMin: 30_000_000,
                salaryMax: 42_000_000,
                currency: "IDR",
                location: "Capital Place, Gatot Subroto, Jakarta",
                jobDescription: "Define architecture roadmaps, technical standards, and scalability frameworks for Indonesia's premier digital wallet app.",
                requirements: [
                    "7+ years building enterprise iOS apps with large user bases",
                    "Mastery of Swift concurrency, memory profiling, and security standards",
                    "Track record of leading mobile core teams and SDK development"
                ],
                keywords: [
                    "iOS Architecture",
                    "Swift Concurrency",
                    "Security",
                    "Fintech",
                    "SDK"
                ],
                aiSuggestion: "Highlight your app performance profiling experience and biometric auth security implementations.",
                jobUrl: "dana.id/careers/ios-architect",
                attachments: [
                    "DANA_Arch_Spec.pdf"
                ]
            ),
            
            JobApplicationModel(
                company: "Grab",
                position: "Lead Product Designer",
                status: .assessment,
                workLocation: .remote,
                employment: .fullTime,
                priority: .medium,
                createdAt: calendar.date(byAdding: .day, value: -4, to: now) ?? now,
                updatedAt: calendar.date(byAdding: .day, value: -2, to: now) ?? now,
                dateAssessment: calendar.date(byAdding: .day, value: 4, to: now),
                salaryMin: 8500,
                salaryMax: 12000,
                currency: "SGD",
                location: "Marina One, Singapore",
                jobDescription: "Lead design initiatives across GrabFood and GrabMart merchant platforms to empower small businesses across Southeast Asia.",
                requirements: [
                    "6+ years in product design and design leadership",
                    "Proven track record in merchant or B2B SaaS product design",
                    "Mastery of Figma design systems and user journey mapping"
                ],
                keywords: [
                    "Design Leadership",
                    "B2B SaaS",
                    "Design System",
                    "Merchant UX"
                ],
                aiSuggestion: "Focus your design assessment presentation on measurable merchant business impact.",
                jobUrl: "grab.careers/lead-product-designer",
                attachments: [
                    "Grab_Design_Brief.pdf"
                ]
            )
        ]
    }
}
