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
    var quizesPlayed: Double
    var timeSpent: Double
    
    private let titleFont = IDQConstants.setFont(fontSize: 32, isBold: true)
    
    var body: some View {
        ZStack {
            IDQStatsUpperView()
                .frame(width: UIScreen.main.bounds.width*4, height: UIScreen.main.bounds.width*4)
                .cornerRadius(UIScreen.main.bounds.width*2)
                .padding(.top, -UIScreen.main.bounds.width*4.20)
            VStack {
                Text("Progression")
                    .frame(width: UIScreen.main.bounds.width-64, height: 50, alignment: .leading)
                    .foregroundColor(Color(IDQConstants.whiteColor))
                    .font(Font(titleFont))
                    .multilineTextAlignment(.leading)
                    .padding(.top, 16)
                Spacer()
                IDQStatsMetricsHStackView(totalScore: totalScore, totalPerformance: totalPerformance, quizesPlayed: quizesPlayed, timeSpent: timeSpent)
                Spacer()
            }
        }
        .background(Color(IDQConstants.backgroundColor))
    }

}

struct IDQStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsView(totalScore: 28, totalPerformance: 0.87, quizesPlayed: 23, timeSpent: 9048)
    }
}
