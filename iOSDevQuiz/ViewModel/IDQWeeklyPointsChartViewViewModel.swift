//
//  IDQWeeklyPointsChartViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/28/23.
//import Foundation
//import SwiftUI
//import CoreData
import UIKit
import SwiftUI
import CoreData

struct IDQWeeklyPointsChartBarViewViewModel: Identifiable {

    var id = UUID()

    private let quizResultManager = IDQQuizResultManager()


    private func fetchResults(_ startingDate: Date, _ endingDate: Date) -> Int {
        var returnValue: Int = 0
        guard let allResults: [IDQQuizResult] = quizResultManager.fetchResults() else {
            return returnValue
        }
        for result in allResults {
            guard let resultDate = result.date else {
                break
            }
            if resultDate >= startingDate && resultDate <= endingDate {
                let points: Int = Int(result.totalScore)
                returnValue += points
            }
        }
        return returnValue
    }
    
    //MARK: - Public
    
    public func generateThisWeeksResults(completion: @escaping ([IDQScoreForDay]) -> Void) {
        let datesForCurrentWeek: [Date] = Date().datesForWeek()
        var dayOfWeekScores: [IDQScoreForDay] = []
        
        DispatchQueue.global(qos: .userInitiated).async {
            var i: Int = 0
            for dates in datesForCurrentWeek {
                guard datesForCurrentWeek.count > i else {
                    break
                }
                let date: Date = datesForCurrentWeek[i]
                let dayScore: Int = self.fetchResults(date, date.addingTimeInterval(3600*24))
                
                let dayOfWeekScore = IDQScoreForDay(
                    date: date,
                    day: IDQDayOfWeek.name(at: i)!,
                    score: dayScore
                )
                dayOfWeekScores.append(dayOfWeekScore)
                i += 1
            }
            
            DispatchQueue.main.async {
                completion(dayOfWeekScores)
            }
        }
    }

}

enum IDQDayOfWeek: String, CaseIterable {
    case sunday = "Sun"
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
    case thursday = "Thu"
    case friday = "Fri"
    case saturday = "Sat"
    
    static func name(at index: Int) -> IDQDayOfWeek? {
        guard index >= 0, index < IDQDayOfWeek.allCases.count else {
            return nil
        }
        return IDQDayOfWeek.allCases[index]
    }
}

struct IDQScoreForDay: Identifiable {
    var id = UUID()
    let date: Date
    let day: IDQDayOfWeek
    var score: Int
}
