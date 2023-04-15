//
//  IDQTopicMetrics+CoreDataProperties.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//
//

import Foundation
import CoreData


extension IDQTopicMetrics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IDQTopicMetrics> {
        return NSFetchRequest<IDQTopicMetrics>(entityName: "IDQTopicMetrics")
    }

    @NSManaged public var topicName: String?
    @NSManaged public var performance: Double
    @NSManaged public var score: Int64
    @NSManaged public var numberOfQuestionsSeen: Int64
    @NSManaged public var wrongAnswerCount: Int64

}

extension IDQTopicMetrics : Identifiable {

}
