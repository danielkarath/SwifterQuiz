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
    private let sideBoxSize: CGFloat = UIScreen.screenHeight > 1080 ? 220 : 90
    private let midBoxSize: CGFloat = UIScreen.screenHeight > 1080 ? 300 : 140
    private let topPadding: CGFloat = UIScreen.screenHeight > 1080 ? 64 : 32
    
    var body: some View {
        VStack {
            HStack {
                IDQTargetView(value: totalPerformance)
                    .frame(width: sideBoxSize, height: sideBoxSize)
                IDQTrophyView(value: totalScore)
                    .frame(width: midBoxSize, height: midBoxSize)
                IDQStreakView(value: streak)
                    .frame(width: sideBoxSize, height: sideBoxSize)
            }
            .padding(.top, topPadding)
            Spacer()
        }
    }
}

struct IDQMainStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQMainStatsView(totalScore: 19, totalPerformance: 89.30, streak: 2)
    }
}
