//
//  IDQStatsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI
import CoreData

struct IDQStatsView: View {
    
    var totalScore: Double
    var totalPerformance: Double
    var averageSpeed: Double
    var quizesPlayed: Double
    var timeSpent: Double
    var streak: Double
    
    
    var body: some View {
        ZStack {
            IDQStatsUpperView()
                .frame(width: UIScreen.main.bounds.width*4, height: UIScreen.main.bounds.width*4)
                .cornerRadius(UIScreen.main.bounds.width*2)
                .padding(.top, -UIScreen.main.bounds.width*4.20)
            VStack {
                ZStack {
                    IDQMainStatsView(totalScore: totalScore, totalPerformance: totalPerformance, streak: streak)
                    ScrollView(.vertical) {
                        Spacer(minLength: UIScreen.main.bounds.width/1.30)
                        IDQStatsMetricsHStackView(speed: averageSpeed, totalPerformance: totalPerformance, quizesPlayed: quizesPlayed, timeSpent: timeSpent)
                    }
                }
            }
        }
        .background(Color(IDQConstants.backgroundColor))
    }

}

struct IDQStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsView(totalScore: 28, totalPerformance: 0.87, averageSpeed: 140, quizesPlayed: 23, timeSpent: 9048, streak: 2)
    }
}
