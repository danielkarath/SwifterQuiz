//
//  IDQQuizResultManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//

import UIKit
import CoreData

final class IDQQuizResultManager {
    
    private let userManager = IDQUserManager()
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    //MARK: - Private
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func getRecordsCount() -> Int? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "IDQQuizResult")
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func saveTo(_ user: IDQUser, quiz: IDQQuiz) {
        guard let totalQuizCount = getRecordsCount() else {
            print("totalQuizCount is nil. Could not execute saveTo(_ user: IDQUser, quiz: IDQQuiz) in IDQResultViewViewModel")
            return
        }
        print("totalQuizCount: \(totalQuizCount)")
        var weightedTotalPerformance: Double = 0.0
        if totalQuizCount <= 1 {
            weightedTotalPerformance = Double(quiz.totalScore)/Double(quiz.questions.count)
        } else {
            let previousTotal: Double = Double(user.numberOfQuizesPlayed) * user.performance
            let currentPerformance: Double = Double(quiz.totalScore)/Double(quiz.questions.count)
            weightedTotalPerformance = (previousTotal + currentPerformance) / (Double(user.numberOfQuizesPlayed) + 1.0)
        }
        user.totalScore += Int64(quiz.totalScore)
        user.performance = weightedTotalPerformance
        user.numberOfQuizesPlayed += 1

        do {
            try context.save()
            print("Successfully saved quiz results to Core Data under an entity IDQUser")
            //fetchResults()
        } catch let error as NSError {
            print("Failed to save quiz results to Core Data under an entity IDQUser: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    //MARK: - Public
    
    public var results: [IDQQuizResult] = []
    
    public func fetchResults() -> [IDQQuizResult]? {
        do {
            let results: [IDQQuizResult] = try context.fetch(IDQQuizResult.fetchRequest())
            if !results.isEmpty {
                self.results = results
                return results
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func save(quiz: IDQQuiz) {
        let result = IDQQuizResult(context: context)
        result.date = quiz.date
        result.duration = quiz.quizDuration
        result.numberOfQuestions = Int64(quiz.questions.count)
        result.score = Int64(quiz.totalScore)
        result.performance = Double(Double(quiz.totalScore)/Double(quiz.questions.count))
        do {
            print("Successfully saved quiz results to Core Data under an entity IDQQuizResult")
            try context.save()
        } catch let error as NSError {
            print("Failed to save quiz results to Core Data under an entity IDQQuizResult: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    public func saveToUserRecords(_ quiz: IDQQuiz) {
        guard let user = userManager.fetchUser() else {
            print("userManager.myUser  is nil. Could not execute saveToUserRecords in IDQResultViewViewModel")
            return
        }
        saveTo(user, quiz: quiz)
    }
    
    
}
