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
    
    private let quizResultManager = IDQQuizResultManager()
    private let userManager = IDQUserManager()
    
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
        guard !quiz.questions.isEmpty else {
            return
        }
        quizResultManager.save(quiz: quiz)
        quizResultManager.saveToMetrics(quiz)
    }
    
    public func saveToUserRecords(_ quiz: IDQQuiz) {
        guard !quiz.questions.isEmpty else {
            return
        }
        quizResultManager.saveToUserRecords(quiz)
    }
    
    public func evaulateStreak(for quiz: IDQQuiz) {
        let user = userManager.fetchUser()
        guard let streak = user?.streak else {
            print("Could not find user streak")
            return
        }
        userManager.evaulateStreak(for: quiz)
    }
    
}
