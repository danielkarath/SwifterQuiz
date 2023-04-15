//
//  IDQTopicMetricManager.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//

import UIKit
import CoreData

final class IDQTopicMetricManager {
    
    //MARK: - Init
    init(
        
    ) {
        
    }
    
    //MARK: - Private
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Pubic
    public var myUser: IDQUser?
    
    
    public func fetchMetrics(for topic: IDQTopic) -> IDQTopicMetrics? {
        do {
            let metrics: [IDQTopicMetrics] = try context.fetch(IDQTopicMetrics.fetchRequest())
            for metric in metrics {
                if metric.topicName == String(describing: topic) {
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
        for caseValue in IDQTopic.allCases {
            let caseName = String(describing: caseValue)
            let newMetric = IDQTopicMetrics(context: context)
            newMetric.topicName = caseName
            newMetric.numberOfQuestionsSeen = 0
            newMetric.performance = 1.0
            newMetric.score = 0
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
