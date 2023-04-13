//
//  IDQResultViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//
import UIKit
import CoreData

final class IDQResultViewViewModel {
    
    enum ScoreType {
        case perfect
        case outstanding
        case good
        case medium
        case low
    }
    
    //MARK: - Private
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func fetchUser() -> IDQUser? {
        do {
            let user: [IDQUser] = try context.fetch(IDQUser.fetchRequest())
            if !user.isEmpty {
                return user.first
            } else {
                return nil
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
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
        var weightedTotalPerformance: Double = 1.0
        if totalQuizCount <= 0 {
            weightedTotalPerformance = Double(quiz.totalScore)/Double(quiz.questions.count)
        } else {
            weightedTotalPerformance = Double(totalQuizCount) * user.performance
            weightedTotalPerformance += Double(quiz.totalScore)/Double(quiz.questions.count)
            weightedTotalPerformance = weightedTotalPerformance / Double(totalQuizCount) + 1
        }
        user.totalScore += Int64(quiz.totalScore)
        user.performance = weightedTotalPerformance

        do {
            print("Successfully saved quiz results to Core Data under an entity IDQUser")
            try context.save()
        } catch let error as NSError {
            print("Failed to save quiz results to Core Data under an entity IDQUser: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }
    }
    
    private func evaulate(quiz: IDQQuiz) -> ScoreType {
        guard quiz.totalScore > 0 else {
            return .low
        }
        let percentage: Double = Double(Double(quiz.totalScore)/Double(quiz.questions.count))
        if percentage < 0.35 {
            return .low
        } else if percentage < 0.70 {
            return .medium
        } else if percentage < 0.90 {
            return .good
        } else if percentage < 1.0 {
            return .outstanding
        } else {
            return .perfect
        }
    }
    
    private func lowCountAnimation(_ label: UILabel, duration: TimeInterval, resultNumber: Int) {
        var counter = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.40, repeats: true) { timer in
            DispatchQueue.main.async {
                label.text = "\(counter)"
                if counter == resultNumber {
                    label.text = "\(counter)"
                    timer.invalidate()
                }
                counter += 1
            }
        }
    }
    
    private func mediumCountAnimation(_ label: UILabel, duration: TimeInterval, resultNumber: Int) {
        var counter = 0
        if resultNumber > 3 {
            let timer1 = Timer.scheduledTimer(withTimeInterval: 0.14, repeats: true) { timer in
                DispatchQueue.main.async {
                    label.text = "\(counter)"
                    if counter == resultNumber-3 {
                        self.finalCountAnimation(label, duration: duration, resultNumber: resultNumber)
                        timer.invalidate()
                    }
                    counter += 1
                }
            }
        } else {
            lowCountAnimation(label, duration: duration, resultNumber: resultNumber)
        }
    }
    
    private func finalCountAnimation(_ label: UILabel, duration: TimeInterval, resultNumber: Int) {
        let firstDelay: TimeInterval = 0.32
        let secondDelay: TimeInterval = 0.46 + firstDelay
        let thirdDelay: TimeInterval = 0.66 + secondDelay
        
        let timer1 = Timer.scheduledTimer(withTimeInterval: firstDelay, repeats: false) { timer in
            DispatchQueue.main.async {
                label.text = String(resultNumber - 2)
                self.pulseFont(label: label, targetSize: 1.30, duration: 0.20)
            }
        }
        
        let timer2 = Timer.scheduledTimer(withTimeInterval: secondDelay, repeats: false) { timer in
            DispatchQueue.main.async {
                label.text = String(resultNumber - 1)
                self.pulseFont(label: label, targetSize: 1.70, duration: 0.30)
            }
        }
        
        let timer3 = Timer.scheduledTimer(withTimeInterval: thirdDelay, repeats: false) { timer in
            DispatchQueue.main.async {
                label.text = String(resultNumber)
                self.pulseFont(label: label, targetSize: 2.20, duration: 0.40)
                self.vibrate(for: .success)
            }
        }
    }
    
    
    private func pulseFont(label: UILabel, targetSize: CGFloat, duration: TimeInterval) {
        guard duration > 0.11 else {
            return
        }
        let growDuration: TimeInterval = duration * 0.35
        
        //Grow animation
        UIView.animate(withDuration: growDuration, delay: 0, animations: {
            label.transform = CGAffineTransform(scaleX: targetSize, y: targetSize)
        }, completion: { (finished) in
            //Shrink animation
            UIView.animate(withDuration: duration-growDuration, delay: 0, animations: {
                label.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })

    }
    
    /// Play haptic for a given type
    /// - Parameter type: Type to vibrate for
    private func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    private func evaulate(duration: TimeInterval) -> Double {
        let threeSec: TimeInterval = 3
        if duration > threeSec + 1 {
            return floor(duration/(threeSec)) * (threeSec)
        } else {
            return 0
        }
    }
    
    private func evaulate(performance: Double) -> Double {
        let fivePercentage: Double = 5
        let randStartingPointArray: [Double] = [8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0]
        var returnValue: Double = floor(performance/(fivePercentage)) * (fivePercentage)
        if returnValue >= 99 {
            return returnValue - (randStartingPointArray.randomElement() ?? 16.0)
        } else if returnValue.truncatingRemainder(dividingBy: 1) == 0 {
            return returnValue - (randStartingPointArray.randomElement() ?? 17.0) - 3
        } else {
            return returnValue
        }
    }
    
    //MARK: - Public
    public func countAnimation(_ label: UILabel, duration: TimeInterval, quiz: IDQQuiz) {
        let scoreType = evaulate(quiz: quiz)
        guard quiz.totalScore > 0 else {
            lowCountAnimation(label, duration: duration, resultNumber: 0)
            return
        }
        
        switch scoreType {
        case .perfect:
            mediumCountAnimation(label, duration: duration, resultNumber: quiz.totalScore)
        case .outstanding:
            mediumCountAnimation(label, duration: duration, resultNumber: quiz.totalScore)
        case .good:
            mediumCountAnimation(label, duration: duration, resultNumber: quiz.totalScore)
        case .medium:
            mediumCountAnimation(label, duration: duration, resultNumber: quiz.totalScore)
        case .low:
            lowCountAnimation(label, duration: duration, resultNumber: quiz.totalScore)
        }
    }
    
    public func countTimeAnimation(_ label: UILabel, quiz: IDQQuiz) {
        let roundedInterval = round(quiz.quizDuration * 100) / 100 //600.00
        
        let counterModifier: Double = evaulate(duration: quiz.quizDuration)
        var counter: Double = 0.00 + counterModifier
        let timer = Timer.scheduledTimer(withTimeInterval: 0.010, repeats: true) { timer in
            DispatchQueue.main.async {
                var formatedCounter: Double = round(counter * 100) / 100
                var timeDurationString: String =  String(formatedCounter)
                if formatedCounter.truncatingRemainder(dividingBy: 1) == 0 {
                    let formattedString = String(format: "%.2f", formatedCounter)
                    timeDurationString = formattedString
                }
                
                timeDurationString = timeDurationString.replacingOccurrences(of: ".", with: ":")
                label.text = timeDurationString
                
                if counter >= roundedInterval {
                    //var timeDurationString: String =  String(roundedInterval)
                    if roundedInterval.truncatingRemainder(dividingBy: 1) == 0 {
                        let formattedString = String(format: "%.2f", roundedInterval)
                        timeDurationString = formattedString
                    }
                    timeDurationString = timeDurationString.replacingOccurrences(of: ".", with: ":")
                    label.text = timeDurationString
                    timer.invalidate()
                }
                counter += 0.01
            }
        }
    }
    
    public func performanceAnimation(_ label: UILabel, quiz: IDQQuiz) {
        let maxScore = quiz.questions.count
        let userScore = quiz.totalScore
        let performance: Double = Double(Double(userScore)/Double(maxScore))*100
        
        let counterModifier: Double = evaulate(performance: performance)
        
        var counter: Double = 0.00 + counterModifier
        let timer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { timer in
            DispatchQueue.main.async {
                label.text = "\(counter)%"
                if counter >= performance {
                    if performance.truncatingRemainder(dividingBy: 1) == 0 {
                        let formattedString = String(format: "%.0f", performance)
                        label.text = "\(formattedString)%"
                    } else {
                        label.text = "\(performance)%"
                    }
                    timer.invalidate()
                }
                counter += 1.00
            }
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
        guard let user = fetchUser() else {
            return
        }
        saveTo(user, quiz: quiz)
    }
    
}
