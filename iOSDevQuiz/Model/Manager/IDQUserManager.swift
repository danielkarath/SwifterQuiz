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
            if count == 1 {
                if let fetchedUser = fetchUser() {
                    myUser = fetchedUser
                }
            }
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
    public var myUser: IDQUser?
    
    public func printUserRecord() {
        guard let user = fetchUser() else {
            print("Could not load User or there is none")
            return
        }
        myUser = user
        print("\n\n------------------------------")
        print("\t\tUSER DATA\n")
        print("User name: \(user.firstName)\n")
        print("Total score: \(user.totalScore)")
        print("Total performance: \(user.performance)")
        print("number of games played: \(user.numberOfQuizesPlayed)")
        print("------------------------------\n\n")
    }
    
    public func fetchUser() -> IDQUser? {
        do {
            let user: [IDQUser] = try context.fetch(IDQUser.fetchRequest())
            if !user.isEmpty {
                myUser = user.first
                return user.first
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
            //user.bookmarkedQuestions = []
            //user.disabledQuestions = []
            do {
                print("Successfully generated a user")
                try context.save()
            } catch let error as NSError {
                print("Failed to generated a user. Error: \(error), \(error.userInfo)")
                // Handle the error appropriately, such as showing an error message to the user
            }
        } else {
            print("There is already a user assigned.")
            printUserRecord()
        }
        topicMetricsManager.createMetrics()
        difficultyMetricsManager.createMetrics()
    }
    
    public func evaulateStreak(for quiz: IDQQuiz) {
        let user = fetchUser()
        let calendar = Calendar.current
        guard let previousGameDate = user?.lastDatePlayed else {
            user?.streak = 1
            saveToCoreData()
            return
        }
        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: quiz.date)!
        let isSameCalendarDate = calendar.isDate(quiz.date, equalTo: previousGameDate, toGranularity: .day)

        if !isSameCalendarDate && user?.lastDatePlayed == yesterdayDate {
            print("The user played their last game the day before so it's time to add 1 to their streak")
            user?.streak += 1
            saveToCoreData()
        } else if isSameCalendarDate {
            print("Streak evaulatin has already been done today. No further actions needed.")
        } else {
            user?.streak = 1
            saveToCoreData()
        }
    }
    
    
}
