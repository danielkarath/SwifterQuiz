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
    var streak: Double
        
    private let midOffset: CGFloat = {
        if UIScreen.screenHeight < 700 {
            return 240
        } else if UIScreen.screenHeight < 880 {
            return 300
        } else if UIScreen.screenHeight < 940 {
            return 325
        } else if UIScreen.screenHeight < 1080 {
            return 300
        } else {
            return 260
        }
    }()
    
    private let viewModel = IDQStatsViewViewModel()
    
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
                        Spacer(minLength: midOffset)
                        IDQStatsMetricsHStackView(quizesPlayed: quizesPlayed, timeSpent: viewModel.setupGameTime(for: timeSpent), gameTimeText: viewModel.setupTextFor(totalGameTime: timeSpent))
                    }
                }
            }
        }
        .background(Color(IDQConstants.backgroundColor))
    }

}

struct IDQStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsView(totalScore: 28, totalPerformance: 0.87, quizesPlayed: 23, timeSpent: 9048, streak: 2)
    }
}
