//
//  HomeView.swift
//  career-bro-app
//
//  Created by Raka Febrian Syahputra on 05/07/26.
//

import SwiftUI
import Charts

struct HomeView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 24) {
            VStack (alignment: .leading) {
                Text("Good Morning")
                    .foregroundStyle(.baseText)
                Text("Raka Febrian")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            VStack(alignment: .leading) {
                Text("Journey Summary")
                    .fontWeight(.medium)
                SummaryChartView(data: SummaryData.dummyData)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(SummaryData.dummyData) {
                            item in
                            SummaryCardView(data: item)
                        }
                    }
                }
                .padding(.top, 4)
            }
            HStack (alignment: .top, spacing: 12) {
                Image(systemName: "sparkles.2")
                    .padding(8)
                    .foregroundStyle(Color.white)
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
            
            VStack{
                Text("Upcoming")
                    .fontWeight(.medium)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        
    }
}

#Preview {
    HomeView()
}
