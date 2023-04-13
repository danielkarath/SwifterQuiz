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
    @NSManaged public var bookmarkedQuestions: NSObject?
    @NSManaged public var disabledQuestions: NSObject?

}

extension IDQUser : Identifiable {

}
