//
//  HomeView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import SwiftUI
import Charts
import SwiftData

struct HomeView: View {
    @Query(sort: \JobApplicationModel.createdAt, order: .reverse) private var applications: [JobApplicationModel]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack (alignment: .leading, spacing: 24) {
                    VStack (alignment: .leading) {
                        Text("Good Morning")
                            .foregroundStyle(.baseText)
                        Text("Raka Febrian")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    
                    Text("Journey Summary")
                        .fontWeight(.medium)
                    
                    JourneySummaryView(SwiftDataSeeder.computeJourneySummary(from: applications))
                    
                    HStack (alignment: .top, spacing: 12) {
                        Image(systemName: "sparkles.2")
                            .padding(8)
                            .foregroundStyle(Color.baseWhite)
                            .background(.bgPrimary)
                            .clipShape(.circle)
                        VStack (alignment: .leading) {
                            Text("AI Insight")
                                .fontWeight(.medium)
                                .font(.callout)
                                .foregroundStyle(.bgPrimary)
                            Text("You’ve applied to 10 Product Designer roles. Consider expanding to UI/UX Designer opportunities")
                                .font(.caption)
                                .fontWeight(.light)
                                .foregroundStyle(.bgPrimary)
                        }
                    }
                    .padding(12)
                    .background(Color(hex: "EEECFE"))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    
                    VStack {
                        Text("Upcoming")
                            .fontWeight(.medium)
                    }
                    
                    ScrollView {
                        ForEach(applications.prefix(3)) { jobCard in
                            NavigationLink(destination: ApplicationDetailView(job: jobCard)) {
                                JobCardView(job: jobCard, showHeader: true)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    Text("Career DNA")
                        .fontWeight(.medium)
                    CareerDNAStatsView()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(SwiftDataSeeder.previewContainer)
}
