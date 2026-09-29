//
//  CareerDNAView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 28/09/26.
//

import SwiftUI

struct CareerDNAView: View {
    @Environment(AppNavigationRouter.self) private var router: AppNavigationRouter?
    @State private var questions: [CareerAssessmentQuestionModel] = CareerAssessmentLoader.loadQuestions()
    @State private var navigateToAssessment: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    CareerDNAHeroCardView()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Career DNA Statistics")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.baseText)

                        CareerDNAStatsView(showViewFullButton: false)
                    }

                    CareerDNAAnalyzeTagsView()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("History")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(.baseText)

                        VStack(spacing: 10) {
                            CareerDNAHistoryItemView(title: "Art - Tech", date: "Oct 12, 2026")
                            CareerDNAHistoryItemView(title: "Analyst - Finance", date: "Oct 12, 2026")
                            CareerDNAHistoryItemView(title: "Medical", date: "Oct 12, 2026")
                            CareerDNAHistoryItemView(title: "Medical", date: "Oct 12, 2026")
                        }
                    }

                    CareerDNASummaryStatsView(
                        questionsCount: questions.isEmpty ? 25 : questions.count
                    )

                    if questions.isEmpty {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.right")
                                .font(.footnote)
                                .foregroundStyle(.baseWhite)
                            Text("Start Assessment")
                                .foregroundStyle(.baseWhite)
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#CCCCCC"))
                        .clipShape(RoundedRectangle(cornerRadius: 99))
                        .disabled(true)
                        .padding(.top, 4)
                    } else {
                        Button {
                            navigateToAssessment = true
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.right")
                                    .font(.footnote)
                                    .foregroundStyle(.baseWhite)
                                Text("Start Assessment")
                                    .foregroundStyle(.baseWhite)
                                    .fontWeight(.medium)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color.bgPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 99))
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 4)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 28)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navigateToAssessment) {
                CareerAssessmentView(questions: questions)
            }
            .onChange(of: router?.navigateToCareerAssessment) { _, shouldNav in
                if shouldNav == true {
                    navigateToAssessment = true
                    router?.navigateToCareerAssessment = false
                }
            }
            .onAppear {
                questions = CareerAssessmentLoader.loadQuestions()
                if router?.navigateToCareerAssessment == true {
                    navigateToAssessment = true
                    router?.navigateToCareerAssessment = false
                }
            }
        }
    }
}

#Preview {
    CareerDNAView()
}
