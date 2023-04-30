//
//  IDQUserManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import UIKit
import CoreData

final class IDQUserManager {
    
    private let topicMetricsManager = IDQTopicMetricManager()
    private let difficultyMetricsManager = IDQDifficultyMetricManager()
    private let daytimeGroupManager = IDQDaytimeActivityGroupManager()
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    //MARK: - Private
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func getRecordsCount() -> Int? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IDQUser")
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func saveToCoreData() {
        do {
            print("Successfully saved user data")
            try context.save()
        } catch let error as NSError {
            print("Failed to save user data to user Error: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    //MARK: - Pubic
    
    public func printUserRecord() {
        guard let user = fetchUser() else {
            print("Could not load User or there is none")
            return
        }
        print("\n\n------------------------------")
        print("\t\tUSER DATA\n")
        print("User name: \(user.firstName)")
        print("Last play date: \(user.lastDatePlayed)")
        print("Total score: \(user.totalScore)")
        print("Total performance: \(user.performance)")
        print("number of games played: \(user.numberOfQuizesPlayed)")
        print("number of bookmarked questions: \(user.bookmarkedQuestions.count)")
        if user.bookmarkedQuestions.count != 0 {
            print("The bookmarked questions are:")
            for question in user.bookmarkedQuestions {
                var disabledQuestion: IDQQuestion = question as! IDQQuestion
                print(disabledQuestion.question)
            }
        }
        if user.disabledQuestions.count != 0 {
            for question in user.disabledQuestions {
                var bookmarkedQuestion: IDQQuestion = question as! IDQQuestion
                print(bookmarkedQuestion.question)
            }
        }
        print("------------------------------\n\n")
    }
    
    public func fetchUser() -> IDQUser? {
        do {
            let user: [IDQUser] = try context.fetch(IDQUser.fetchRequest())
            if !user.isEmpty {
                if let safeUser = user.first as? IDQUser {
                    return safeUser
                } else {
                    print("The first element of the fetched [IDQUser] array is not an IDQUser. There is a bug in IDQUserManager fetchUser")
                    return nil
                }
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func createUser(name: String?) {
        guard let userCount = getRecordsCount() else {
            print("Could not evaulate userCount while trying to generate new user")
            return
        }
        if userCount <= 0 {
            let user = IDQUser(context: context)
            user.firstName = name ?? "User"
            user.performance = 0.0
            user.totalScore = 0
            user.numberOfQuizesPlayed = 0
            user.totalPlayTime = 0
            user.streak = 0
            user.bookmarkedQuestions = []
            user.disabledQuestions = []
            do {
                print("Successfully generated a user")
                try context.save()
            } catch let error as NSError {
                print("Failed to generated a user. Error: \(error), \(error.userInfo)")
                // Handle the error appropriately, such as showing an error message to the user
            }
            topicMetricsManager.createMetrics()
            difficultyMetricsManager.createMetrics()
            daytimeGroupManager.generateDaytimeGroups()
        } else {
            print("There is already a user assigned.")
            //printUserRecord()
        }
    }
    
//    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: date1)
//        guard let date1Midnight = calendar.date(from: components) else { return false }
//
//        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
//        guard let date2Midnight = calendar.date(from: components2) else { return false }
//
//        return date1Midnight == date2Midnight
//    }
//
//    func getTodayMidnightDate() -> Date? {
//        let calendar = Calendar.current
//        let now = Date()
//        let dateComponents = calendar.dateComponents([.year, .month, .day], from: now)
//        guard let midnight = calendar.date(from: dateComponents) else { return nil }
//        return midnight
//    }
//
//    private func isDate(_ date: Date, between startDate: Date, and endDate: Date) -> Bool {
//        return date >= startDate && date <= endDate
//    }
    
    public func evaulateStreak(didPlayYesterday: Bool) {
        let calendar = Calendar.current
        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: Date.currentTime) ?? Date.currentTime.addingTimeInterval(-3600*24)
        let midnight: Date = Date.getTodayMidnightDate() ?? yesterdayDate.addingTimeInterval(60)
        guard let user = fetchUser() else {
            print("Could not load user while trying to set streak")
            return
        }

        guard let previousGameDate = user.lastDatePlayed else {
            print("Could not load previous game while trying to set streak")
            return
        }
        
        let hasPlayedAlreadyToday = Date.isDate(previousGameDate, between: midnight, and: Date.currentTime)
        
        
        if hasPlayedAlreadyToday || didPlayYesterday {
            print("Streak is evaulated and no changes needed")
        } else {
            print("Streak is evaulated and the user's last game was not today or yesterday")
            user.streak = 0
            saveToCoreData()
        }
        
    }
    
    public func shouldAddToStreak() {
        let calendar = Calendar.current
        guard let user = fetchUser() else {
            print("Could not load user while trying to set streak")
            return
        }
        
        guard let previousGameDate = user.lastDatePlayed else {
            user.streak = 1
            saveToCoreData()
            print("Could not load previous game while trying to set streak")
            return
        }
        
        let hasPlayedAlreadyToday = calendar.isDate(Date.currentTime, equalTo: previousGameDate, toGranularity: .day)
        
        if hasPlayedAlreadyToday {
            if user.streak < 1 {
                user.streak = 1
                saveToCoreData()
            }
        } else {
            user.streak += 1
            saveToCoreData()
        }
    }
}
