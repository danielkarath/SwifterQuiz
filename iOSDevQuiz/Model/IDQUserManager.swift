//
//  IDQUserManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import UIKit
import CoreData

final class IDQUserManager {
    
    private let metricsManager = IDQTopicMetricManager()
    
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
        metricsManager.createMetrics()
    }
}
