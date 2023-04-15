//
//  IDQDifficultyMetrics+CoreDataProperties.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//
//

import Foundation
import CoreData


extension IDQDifficultyMetrics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IDQDifficultyMetrics> {
        return NSFetchRequest<IDQDifficultyMetrics>(entityName: "IDQDifficultyMetrics")
    }

    @NSManaged public var difficultyName: String?
    @NSManaged public var questionsSeen: Int64
    @NSManaged public var correctAnswerCount: Int64
    @NSManaged public var incorrectAnswerCount: Int64
    @NSManaged public var performance: Double

}

extension IDQDifficultyMetrics : Identifiable {

}
