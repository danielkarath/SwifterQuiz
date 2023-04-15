//
//  IDQLineChart.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//
import Foundation
import SwiftUI
import Charts

struct DataPoint {
    let day: Int
    let value: Double
}

import SwiftUI

struct SmoothLine: Shape {
    let dataPoints: [DataPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstDataPoint = dataPoints.first else { return path }

        let calendar = Calendar.current
        let daysInCurrentMonth = calendar.numberOfDaysInCurrentMonth()
        
        let xScaler = (rect.width) / CGFloat(daysInCurrentMonth)
        let yScaler = rect.height / CGFloat(dataPoints.map { $0.value }.max() ?? 1)

        let startPoint = CGPoint(x: CGFloat(firstDataPoint.day) * xScaler, y: rect.height - CGFloat(firstDataPoint.value) * yScaler)
        path.move(to: startPoint)

        for index in dataPoints.indices.dropFirst() {
            let controlPoint1 = CGPoint(x: (CGFloat(dataPoints[index - 1].day) * xScaler) + xScaler / 2, y: rect.height - CGFloat(dataPoints[index - 1].value) * yScaler)
            let controlPoint2 = CGPoint(x: (CGFloat(dataPoints[index].day) * xScaler) - xScaler / 2, y: rect.height - CGFloat(dataPoints[index].value) * yScaler)
            let endPoint = CGPoint(x: CGFloat(dataPoints[index].day) * xScaler, y: rect.height - CGFloat(dataPoints[index].value) * yScaler)
            path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        }
        return path
    }
}

import SwiftUI

struct IDQLineChart: View {
    let daysInMonth = Calendar.current.numberOfDaysInCurrentMonth()
    let dataPointsThisMonth: [DataPoint]
    let dataPointsLastMonth: [DataPoint]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Last month's data points
                SmoothLine(dataPoints: dataPointsLastMonth)
                    .stroke(Color(IDQConstants.blackColor.withAlphaComponent(0.15)), lineWidth: 7)
                
                // This month's data points
                SmoothLine(dataPoints: dataPointsThisMonth)
                    .stroke(Color(IDQConstants.whiteColor), lineWidth: 7)


                // Dotted X-axis line
                Path { path in
                    path.move(to: CGPoint(x: 24, y: geometry.size.height))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [1, 10]))
                .foregroundColor(Color(IDQConstants.highlightedLightOrange))
            }
        }
    }
}
