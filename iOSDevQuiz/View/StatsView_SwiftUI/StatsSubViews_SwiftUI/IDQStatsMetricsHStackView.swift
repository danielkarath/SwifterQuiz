//
//  IDQStatsMetricsHStackView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import SwiftUI

struct IDQStatsMetricsHStackView: View {
    
    var totalScore: Double
    var totalPerformance: Double
    var quizesPlayed: Double
    var timeSpent: Double
    
    var body: some View {
        HStack(spacing: CGFloat((UIScreen.main.bounds.width - 2 * 160-32)/3)) {
            IDQStatsMetricBoxView(title: "total score", value: totalScore, image: Image(systemName: "sparkles"), resultValueType: .wholeNum)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
            IDQStatsMetricBoxView(title: "performance", value: totalPerformance, image: Image(systemName: "percent"), resultValueType: .percentage)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
            
        }
        .padding(.top, 16)
        HStack(spacing: CGFloat((UIScreen.main.bounds.width - 2 * 160-32)/3)) {
            IDQStatsMetricBoxView(title: "quizes played", value: quizesPlayed, image: Image(systemName: "pencil"), resultValueType: .wholeNum)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
            IDQStatsMetricBoxView(title: "minutes spent", value: timeSpent, image: Image(systemName: "timer"), resultValueType: .time)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
            
        }
        .padding(.top, CGFloat((UIScreen.main.bounds.width - 2 * 160-40)/3))
    }
}

struct IDQStatsMetricsHStackView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsMetricsHStackView(totalScore: 28, totalPerformance: 0.87, quizesPlayed: 23, timeSpent: 9048)
    }
}
