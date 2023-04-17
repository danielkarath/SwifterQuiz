//
//  IDQMainStatsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/16/23.
//

import SwiftUI

struct IDQMainStatsView: View {
    
    var totalScore: Double
    var totalPerformance: Double
    var streak: Double
    
    private let titleFont = IDQConstants.setFont(fontSize: 32, isBold: true)
    
    var body: some View {
        VStack {
            Text("Progression")
                .frame(width: UIScreen.main.bounds.width-64, height: 50, alignment: .leading)
                .foregroundColor(Color(IDQConstants.basicFontColor))
                .font(Font(titleFont))
                .multilineTextAlignment(.leading)
                .padding(.top, 16)
                .padding(.bottom, 32)
            HStack {
                IDQTargetView(value: totalPerformance)
                    .frame(width: 90, height: 90)
                IDQTrophyView(value: totalScore)
                    .frame(width: 140, height: 140)
                IDQStreakView(value: streak)
                    .frame(width: 90, height: 90)
            }
            Spacer()
        }
    }
}

struct IDQMainStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQMainStatsView(totalScore: 19, totalPerformance: 89.30, streak: 2)
    }
}
