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
        print("User name: \(user.firstName)")
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
        print("\nnumber of disabled questions: \(user.disabledQuestions.count)")
        if user.disabledQuestions.count != 0 {
            print("The disabled questions are:")
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
            user.bookmarkedQuestions = []
            user.disabledQuestions = []
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
        daytimeGroupManager.generateDaytimeGroups()
    }
    
    public func evaulateStreak() {
        let user = fetchUser()
        let calendar = Calendar.current
        guard user != nil else {
            return
        }
        guard let previousGameDate = user?.lastDatePlayed else {
            return
        }
        let yesterdayDate = calendar.date(byAdding: .day, value: -1, to: Date.currentTime)!
        let isSameYesterdayDate = calendar.isDate(yesterdayDate, equalTo: previousGameDate, toGranularity: .day)
        let isSameTodayDate = calendar.isDate(Date.currentTime, equalTo: previousGameDate, toGranularity: .day)
        
        if isSameTodayDate || isSameYesterdayDate {
            print("Streak is evaulated and no changes needed")
        } else {
            print("Streak is evaulated and the user's last game was not today or yesterday")
            user?.streak = 0
            saveToCoreData()
        }
    }
    
    public func addToStreak(for quiz: IDQQuiz) {
        guard let user = fetchUser() else {
            print("At UserManager addToStreak could not load the user")
            return
        }
        guard var previousGameDate = user.lastDatePlayed else {
            print("At UserManager addToStreak could not load previousGameDate: \(user.lastDatePlayed)")
            user.streak = 1
            saveToCoreData()
            return
        }
        let calendar = Calendar.current
        let evaulatedTimePeriod: Calendar.Component = .day
        let thisQuizDate: Date = quiz.date
        
        let yesterdayDate = calendar.date(byAdding: evaulatedTimePeriod, value: -1, to: quiz.date)!
        let isSameCalendarDate = calendar.isDate(quiz.date, equalTo: previousGameDate, toGranularity: evaulatedTimePeriod)

        print("yesterdayDate: \(yesterdayDate)")
        print("previousGameDate: \(previousGameDate)")
        print("isSameCalendarDate: \(isSameCalendarDate)")
        
        if !isSameCalendarDate && previousGameDate == yesterdayDate {
            print("The user played their last game the day before so it's time to add 1 to their streak")
            user.streak += 1
            saveToCoreData()
        } else if isSameCalendarDate {
            print("Streak evaulatin has already been done today. No further actions needed.")
        } else {
            print("Did set streak to 1")
            user.streak = 1
            saveToCoreData()
        }
    }
    
    
}
