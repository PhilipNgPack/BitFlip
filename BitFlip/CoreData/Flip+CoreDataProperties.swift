//
//  Flip+CoreDataProperties.swift
//  
//
//  Created by Philip Ng Pack on 8/31/19.
//
//

import Foundation
import CoreData


extension Flip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flip> {
        return NSFetchRequest<Flip>(entityName: "Flip")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var outcome: Int16
    @NSManaged public var coins: Int32
    @NSManaged public var tailsProb: Double
    @NSManaged public var headsProb: Double

}
