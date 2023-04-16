//
//  IDQStatsMetricsHStackView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import SwiftUI

struct IDQStatsMetricsHStackView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var speed: Double
    var totalPerformance: Double
    var quizesPlayed: Double
    var timeSpent: Double
    
    var body: some View {
        HStack(spacing: CGFloat((UIScreen.main.bounds.width - 2 * 160-32)/3)) {
            IDQStatsMetricBoxView(title: "performance", value: totalPerformance, image: Image(systemName: "percent"), resultValueType: .percentage)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: colorScheme == .light ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 5)
            IDQStatsMetricBoxView(title: "speed", value: speed, image: Image(systemName: "timer"), resultValueType: .wholeNum)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: colorScheme == .light ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 5)
        }
        .padding(.top, 16)
        HStack(spacing: CGFloat((UIScreen.main.bounds.width - 2 * 160-32)/3)) {
            IDQStatsMetricBoxView(title: "quizes played", value: quizesPlayed, image: Image(systemName: "pencil"), resultValueType: .wholeNum)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: colorScheme == .light ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 5)
            IDQStatsMetricBoxView(title: "minutes spent", value: timeSpent, image: Image(systemName: "hourglass"), resultValueType: .time)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: colorScheme == .light ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 5)
        }
        .padding(.top, CGFloat((UIScreen.main.bounds.width - 2 * 160-40)/3))
    }
}

struct IDQStatsMetricsHStackView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsMetricsHStackView(speed: 28, totalPerformance: 0.87, quizesPlayed: 23, timeSpent: 9048)
    }
}
