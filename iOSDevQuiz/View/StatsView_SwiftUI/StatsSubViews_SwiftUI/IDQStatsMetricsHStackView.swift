//
//  IDQStatsMetricsHStackView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import SwiftUI

struct IDQStatsMetricsHStackView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var quizesPlayed: Double
    var timeSpent: Double
    var gameTimeText: String
    
    var body: some View {
        HStack(spacing: CGFloat((UIScreen.screenWidth - 2 * 160-32)/3)) {
            IDQStatsMetricBoxView(title: "quizes played", value: quizesPlayed, image: Image(systemName: "graduationcap.fill"), resultValueType: .wholeNum)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: colorScheme == .light ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 5)
            IDQStatsMetricBoxView(title: gameTimeText, value: timeSpent, image: Image(systemName: "hourglass"), resultValueType: .time)
                .background(Color(IDQConstants.contentBackgroundColor))
                .cornerRadius(16)
                .shadow(color: colorScheme == .light ? Color.gray.opacity(0.5) : Color.clear, radius: 5, x: 0, y: 5)
        }
        .padding(.top, CGFloat((UIScreen.screenWidth - 2 * 160-40)/3))
    }
}

struct IDQStatsMetricsHStackView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsMetricsHStackView(quizesPlayed: 23, timeSpent: 9048, gameTimeText: "minutes played")
    }
}
