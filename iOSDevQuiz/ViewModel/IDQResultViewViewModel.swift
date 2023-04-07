//
//  IDQResultViewViewModel.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 3/21/23.
//
import UIKit

final class IDQResultViewViewModel {
    
    enum ScoreType {
        case perfect
        case outstanding
        case good
        case medium
        case low
    }
    
    //MARK: - Private
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
        let secondDelay: TimeInterval = 0.56 + firstDelay
        let thirdDelay: TimeInterval = 0.96 + secondDelay
        
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
    
    public func countTimeAnimation(_ label: UILabel, duration: TimeInterval, quiz: IDQQuiz) {
        print("quiz duration: \(quiz.time)")
        let roundedInterval = round(quiz.time * 100) / 100
        var timeDurationString: String =  String(roundedInterval)
        timeDurationString = timeDurationString.replacingOccurrences(of: ".", with: ":")
        label.text = timeDurationString
//        
//        switch scoreType {
//        case .perfect:
//            mediumCountAnimation(label, duration: duration, resultNumber: quiz.time)
//        case .outstanding:
//            mediumCountAnimation(label, duration: duration, resultNumber: quiz.time)
//        case .good:
//            mediumCountAnimation(label, duration: duration, resultNumber: quiz.time)
//        case .medium:
//            mediumCountAnimation(label, duration: duration, resultNumber: quiz.time)
//        case .low:
//            lowCountAnimation(label, duration: duration, resultNumber: quiz.time)
//        }
    }
    
}
