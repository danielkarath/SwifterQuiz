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
    private let topicMetricManager = IDQTopicMetricManager()
    private let difficultyMetricManager = IDQDifficultyMetricManager()
    
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
        user.totalPlayTime += quiz.quizDuration
        
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
        result.totalScore = Int64(quiz.totalScore)
        result.performance = Double(Double(quiz.totalScore)/Double(quiz.questions.count))
        do {
            print("Successfully saved quiz results to Core Data under an entity IDQQuizResult")
            try context.save()
        } catch let error as NSError {
            print("Failed to save quiz results to Core Data under an entity IDQQuizResult: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    private func save(to metric: IDQTopicMetrics, topic: IDQTopic, questions: [(question: IDQQuestion, answerType: IDQAnswerType)]) {
        var pointsCounter = 0
        var mistakeCount = 0
        var totalCounter = 0
        
        for question in questions {
            if question.question.topic == topic {
                totalCounter += 1
                if question.answerType == .correct {
                    pointsCounter += 1
                } else {
                    mistakeCount += 1
                }
            }
        }
        
        metric.score += Int64(pointsCounter)
        metric.wrongAnswerCount += Int64(mistakeCount)
        metric.numberOfQuestionsSeen += Int64(totalCounter)
        metric.performance = Double(Double(metric.score)/Double(metric.numberOfQuestionsSeen))
        
        do {
            try context.save()
            print("Successfully saved quiz results to Core Data under an entity IDQUser")
            //fetchResults()
        } catch let error as NSError {
            print("Failed to save quiz results to Core Data under an entity IDQUser: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    private func save(to metric: IDQDifficultyMetrics, questions: [(question: IDQQuestion, answerType: IDQAnswerType)]) {
        var pointsCounter = 0
        var mistakeCount = 0
        var totalCounter = 0
        
        for question in questions {
            if question.question.difficulty.rawValue == metric.difficultyName {
                totalCounter += 1
                if question.answerType == .correct {
                    pointsCounter += 1
                } else {
                    mistakeCount += 1
                }
            }
        }
        
        metric.correctAnswerCount += Int64(pointsCounter)
        metric.incorrectAnswerCount += Int64(mistakeCount)
        metric.questionsSeen += Int64(totalCounter)
        metric.performance = Double(Double(metric.correctAnswerCount)/Double(metric.questionsSeen))
        
        do {
            try context.save()
            print("Successfully saved quiz results to Core Data under an entity IDQUser")
            //fetchResults()
        } catch let error as NSError {
            print("Failed to save quiz results to Core Data under an entity IDQUser: \(error), \(error.userInfo)")
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
    
    public func saveToMetrics(_ quiz: IDQQuiz) {
        var topicsSeen: [IDQTopic] = []
        var difficultiesSeen: [IDQQuestionDifficulty] = []
        let quizQuestions = quiz.questions
        let questionsSeen: [IDQQuestion] = quizQuestions.map { ($0.question) }
        
        for question in questionsSeen {
            if !topicsSeen.contains(question.topic) {
                topicsSeen.append(question.topic)
            }
            if !difficultiesSeen.contains(question.difficulty) {
                difficultiesSeen.append(question.difficulty)
            }
        }
        
        for topic in topicsSeen {
            guard let metric = topicMetricManager.fetchMetrics(for: topic) else {
                print("topicMetric.fetchMetric is nil. Could not find existing metric for the topic. Maybe need to regenerate topics or add new ones")
                return
            }
            save(to: metric, topic: topic, questions: quizQuestions)
        }
        
        for difficulty in difficultiesSeen {
            guard let metric = difficultyMetricManager.fetchMetrics(for: difficulty) else {
                print("difficultyMetric.fetchMetric is nil. Could not find existing metric for the difficulty. Maybe need to regenerate topics or add new ones")
                return
            }
            save(to: metric, questions: quizQuestions)
        }
    }
}
