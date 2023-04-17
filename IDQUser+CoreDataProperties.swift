//
//  IDQUser+CoreDataProperties.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/15/23.
//
//

import Foundation
import CoreData


extension IDQUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IDQUser> {
        return NSFetchRequest<IDQUser>(entityName: "IDQUser")
    }

    @NSManaged public var bookmarkedQuestions: NSArray//[IDQQuestion]?
    @NSManaged public var disabledQuestions: NSArray//NSObject?//[IDQQuestion]?
    @NSManaged public var firstName: String?
    @NSManaged public var lastDatePlayed: Date?
    @NSManaged public var numberOfQuizesPlayed: Int64
    @NSManaged public var performance: Double
    @NSManaged public var streak: Int64
    @NSManaged public var totalScore: Int64
    @NSManaged public var totalPlayTime: Double

}

extension IDQUser : Identifiable {

}
