//
//  IDQLineChartViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import Foundation
import SwiftUI
import CoreData

final class IDQStatsViewViewModel: ObservableObject {
    
    //MARK: - Private
    private let quizResultManager = IDQQuizResultManager()
    private let userManager = IDQUserManager()
    
    
    //MARK: - Public
    public var results: [IDQQuizResult] = []
    
    public func fetchMonthlyMetrics() -> [IDQQuizResult] {
        var returnArray: [IDQQuizResult] = []
        let calendar = Calendar.current
        guard let startDate = calendar.date(byAdding: .day, value: -30, to: Date()) else {
            return []
        }
        
        let allResults = quizResultManager.fetchResults() ?? quizResultManager.results
        if !allResults.isEmpty {
            for result in allResults {
                guard let resultDate = result.date else {
                    break
                }
                if resultDate > startDate && resultDate < Date() {
                    self.results.append(result)
                    returnArray.append(result)
                    print("Did add a result with date: \(resultDate) and score of \(result.totalScore)")
                }
            }
        }
        return returnArray
    }
    
    
}