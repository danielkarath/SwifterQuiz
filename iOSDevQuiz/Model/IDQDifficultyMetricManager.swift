//
//  IDQDifficultyMetricManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import UIKit
import CoreData

final class IDQDifficultyMetricManager {
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    //MARK: - Private
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Pubic
    
    public func fetchMetrics(for difficulty: IDQQuestionDifficulty) -> IDQDifficultyMetrics? {
        do {
            let metrics: [IDQDifficultyMetrics] = try context.fetch(IDQDifficultyMetrics.fetchRequest())
            for metric in metrics {
                if metric.difficultyName == difficulty.rawValue {
                    return metric
                }
            }
        } catch {
            print(error.localizedDescription)
            return nil
        }
        return nil
    }
    
    public func createMetrics() {
        var counter: Int = 0
        for caseValue in IDQQuestionDifficulty.allCases {
            let caseName = String(describing: caseValue)
            let newMetric = IDQDifficultyMetrics(context: context)
            newMetric.difficultyName = caseName
            newMetric.correctAnswerCount = 0
            newMetric.incorrectAnswerCount = 0
            newMetric.questionsSeen = 0
            counter += 1
        }
        
        do {
            print("Successfully generated \(counter) topic metrics")
            try context.save()
        } catch let error as NSError {
            print("Failed to generated a user. Error: \(error), \(error.userInfo)")
            // Handle the error appropriately, such as showing an error message to the user
        }

    }
}
