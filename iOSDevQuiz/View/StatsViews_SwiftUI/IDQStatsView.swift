//
//  IDQStatsView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI

struct IDQStatsView: View {
    
    var totalScore: Double
    var totalPerformance: Double
    
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
                HStack(spacing: 40) {
                    IDQStatsMetricBoxView(title: "total score", value: totalScore, image: Image(systemName: "sparkles"), isPercentage: false)
                        .background(Color(IDQConstants.contentBackgroundColor))
                        .cornerRadius(16)
                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    IDQStatsMetricBoxView(title: "performance", value: totalPerformance, image: Image(systemName: "percent"), isPercentage: true)
                        .background(Color(IDQConstants.contentBackgroundColor))
                        .cornerRadius(16)
                        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 5)

                }
                .padding(.top, -96)
                Spacer()
            }
        }
        .background(Color(IDQConstants.backgroundColor))
    }
}

struct IDQStatsView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsView(totalScore: 28, totalPerformance: 87.8)
    }
}
