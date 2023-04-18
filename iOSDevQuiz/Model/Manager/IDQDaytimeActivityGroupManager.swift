//
//  IDQDaytimeActivityGroupManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//

import UIKit
import CoreData

final class IDQDaytimeActivityGroupManager {
    
    enum IDQDaytimeGroup: String, CaseIterable, Codable {
        case afterMidnight = "After midnight"
        case morning = "Morning"
        case afternoon = "Daytime"
        case night = "Night"
    }
    
    //MARK: - Init
    init(
    
    ) {
        
    }
    
    //MARK: - Private
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private func saveToCoreData() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save DayTimeActivityGroup to core data. Error: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    private func fetchDaytimeActivityGroups() -> [IDQDaytimeActivityGroup]? {
        do {
            let activityGroups: [IDQDaytimeActivityGroup] = try context.fetch(IDQDaytimeActivityGroup.fetchRequest())
            if !activityGroups.isEmpty {
                return activityGroups
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    //MARK: - Public
    public func fetch(_ quiz: IDQQuiz, for daytimeGroup: IDQDaytimeGroup) -> IDQDaytimeActivityGroup? {
        var returnValue: IDQDaytimeActivityGroup?
        guard let activityGroups = fetchDaytimeActivityGroups() else {
           return nil
        }
        let quizDaytimeGroup = evaulate(for: quiz.date)
        
        for activityGroup in activityGroups {
            if activityGroup.daytimeName == quizDaytimeGroup.rawValue {
                returnValue = activityGroup
                break
            }
        }
        return returnValue
    }
    
    public func evaulate(for date: Date) -> IDQDaytimeGroup {
        var returnValue: IDQDaytimeGroup?
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .minute], from: date)
        if let hour = components.hour, let minute = components.minute {
            
            if hour >= 0 && hour < 6 {
                returnValue = .afterMidnight
            } else if hour >= 6 && hour < 12 {
                returnValue = .morning
            } else if hour >= 12 && hour < 18 {
                returnValue = .afternoon
            } else if hour >= 18 && hour < 24 {
                returnValue = .night
            } else {
                returnValue = .morning
            }
        }
        return returnValue ?? .morning
    }
    
    public func update(_ daytimeActivityGroup: IDQDaytimeActivityGroup, with quiz: IDQQuiz) {
        let totalQuizCount = daytimeActivityGroup.totalNumberOfGames
        
        var weightedTotalPerformance: Double = 0.0
        if totalQuizCount <= 1 {
            weightedTotalPerformance = Double(quiz.totalScore)/Double(quiz.questions.count)
        } else {
            let previousTotal: Double = Double(totalQuizCount) * daytimeActivityGroup.totalPerformance
            let currentPerformance: Double = Double(quiz.totalScore)/Double(quiz.questions.count)
            weightedTotalPerformance = (previousTotal + currentPerformance) / (Double(daytimeActivityGroup.totalNumberOfGames) + 1.0)
        }
        
        daytimeActivityGroup.totalPerformance = weightedTotalPerformance
        daytimeActivityGroup.totalScore += Int64(quiz.totalScore)
        daytimeActivityGroup.totalNumberOfGames += 1
        saveToCoreData()
    }
    
    public func generateDaytimeGroups() {
        var counter: Int = 0
        for caseValue in IDQDaytimeGroup.allCases {
            let caseName = String(describing: caseValue)
            let newDaytimeActivityGroup = IDQDaytimeActivityGroup(context: context)
            newDaytimeActivityGroup.daytimeName = caseName
            newDaytimeActivityGroup.totalNumberOfGames = 0
            newDaytimeActivityGroup.totalPerformance = 0.0
            newDaytimeActivityGroup.totalScore = 0
            counter += 1
        }
        
        saveToCoreData()
    }

}
