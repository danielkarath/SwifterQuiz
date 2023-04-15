//
//  IDQStatsUpperView.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI

struct IDQStatsUpperView: View {
    
    let dataPointsThisMonth: [DataPoint] = [
            DataPoint(day: 1, value: 10),
            DataPoint(day: 2, value: 30),
            DataPoint(day: 3, value: 15),
            DataPoint(day: 4, value: 45),
            DataPoint(day: 5, value: 25),
            DataPoint(day: 6, value: 40),
            DataPoint(day: 7, value: 60),
            DataPoint(day: 8, value: 35),
            DataPoint(day: 9, value: 50),
            DataPoint(day: 10, value: 55)
            // Add more data points for this month if needed
        ]

        let dataPointsLastMonth: [DataPoint] = [
            DataPoint(day: 1, value: 20),
            DataPoint(day: 2, value: 40),
            DataPoint(day: 3, value: 30),
            DataPoint(day: 4, value: 35),
            DataPoint(day: 5, value: 45),
            DataPoint(day: 6, value: 60),
            DataPoint(day: 7, value: 40),
            DataPoint(day: 8, value: 50),
            DataPoint(day: 9, value: 55),
            DataPoint(day: 10, value: 45)
            // Add more data points for last month if needed
        ]
    
    let lightOrange: Color = Color(IDQConstants.highlightedLightOrange)
    let darkOrange: Color = Color(IDQConstants.highlightedDarkOrange)
    let titleFont = IDQConstants.setFont(fontSize: 32, isBold: true)
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    darkOrange,
                    lightOrange
                ]),
                startPoint: .leading,
                endPoint: .topTrailing)
            .edgesIgnoringSafeArea(.all)
            VStack {
                GeometryReader { geometry in
                    VStack {
                        IDQLineChart(dataPointsThisMonth: dataPointsThisMonth, dataPointsLastMonth: dataPointsLastMonth)
                            .frame(width: UIScreen.main.bounds.width-32, height: 200)
                            .padding()
                            .position(x: geometry.size.width / 2.07, y: geometry.size.height - 120)
                    }
                }
            }
        }
    }
}

struct IDQStatsUpperView_Previews: PreviewProvider {
    static var previews: some View {
        IDQStatsUpperView()
    }
}
