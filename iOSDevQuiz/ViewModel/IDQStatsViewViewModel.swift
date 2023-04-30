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
    
    private func fetch(streak: Int64, lastQuizDate: Date) {
        let user = userManager.fetchUser()
        
    }
    
    //MARK: - Public
    public var results: [IDQQuizResult] = []
    
    public func setupGameTime(for gameTime: TimeInterval) -> TimeInterval {
        var returnValue: TimeInterval?
        if gameTime < 60 {
            returnValue = gameTime
        } else if gameTime >= 60 && gameTime < 3600 {
            returnValue = gameTime/60
        } else {
            returnValue = gameTime/3600
        }
        return returnValue ?? 2
    }
    
    public func setupTextFor(totalGameTime: TimeInterval) -> String {
        if totalGameTime <= 0 {
            return "total game time"
        } else if totalGameTime < 60 {
            return "seconds played"
        } else if totalGameTime >= 60 && totalGameTime < 3600 {
            return "minutes played"
        } else {
            return "hours played"
        }
    }
    
    public func fetchMonthlyMetrics() -> [IDQQuizResult] {
        var returnArray: [IDQQuizResult] = []
        let calendar = Calendar.current
        guard let startDate = calendar.date(byAdding: .day, value: -30, to: Date.currentTime) else {
            return []
        }
        
        let allResults = quizResultManager.fetchResults() ?? quizResultManager.results
        if !allResults.isEmpty {
            for result in allResults {
                guard let resultDate = result.date else {
                    break
                }
                if resultDate > startDate && resultDate < Date.currentTime {
                    self.results.append(result)
                    returnArray.append(result)
                }
            }
        }
        return returnArray
    }
}
