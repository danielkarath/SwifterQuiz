//
//  IDQLineChart.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import SwiftUI
import Charts

struct IDQLineChart: View {
    
    public var results: [IDQQuizResult]
    var body: some View {
        Chart {
            LineMark(x: .value("Day", Date()), y: .value("Minutes", 2))
//            ForEach(results) { result in
//                LineMark(x: .value("Day", result.date!), y: .value("Minutes", result.score))
//            }
        }
    }
}

struct IDQLineChart_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = IDQStatsViewViewModel()
        let exampleResults = viewModel.fetchMonthlyMetrics()
        IDQLineChart(results: exampleResults)
    }
}

