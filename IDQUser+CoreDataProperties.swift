//
//  IDQUser+CoreDataProperties.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/13/23.
//
//

import Foundation
import CoreData


extension IDQUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IDQUser> {
        return NSFetchRequest<IDQUser>(entityName: "IDQUser")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var totalScore: Int64
    @NSManaged public var performance: Double
    @NSManaged public var bookmarkedQuestions: NSObject? //[IDQQuestion]?
    @NSManaged public var disabledQuestions: NSObject? //[IDQQuestion]?
    @NSManaged public var numberOfQuizesPlayed: Int64

}

extension IDQUser : Identifiable {

}
