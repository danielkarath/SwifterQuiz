//
//  IDQQuizResult+CoreDataProperties.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//
//

import Foundation
import CoreData


extension IDQQuizResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IDQQuizResult> {
        return NSFetchRequest<IDQQuizResult>(entityName: "IDQQuizResult")
    }

    @NSManaged public var date: Date?
    @NSManaged public var score: Int64
    @NSManaged public var performance: Double
    @NSManaged public var duration: Double
    @NSManaged public var numberOfQuestions: Int64

}

extension IDQQuizResult : Identifiable {

}
