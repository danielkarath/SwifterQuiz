//
//  IDQDaytimeActivityGroup+CoreDataProperties.swift
//  iOSDevQuiz
//
//  Created by Daniel Karath on 4/18/23.
//
//

import Foundation
import CoreData


extension IDQDaytimeActivityGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IDQDaytimeActivityGroup> {
        return NSFetchRequest<IDQDaytimeActivityGroup>(entityName: "IDQDaytimeActivityGroup")
    }

    @NSManaged public var daytimeName: String?
    @NSManaged public var totalScore: Int64
    @NSManaged public var totalPerformance: Double
    @NSManaged public var totalNumberOfGames: Int64

}

extension IDQDaytimeActivityGroup : Identifiable {

}
