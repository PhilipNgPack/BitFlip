//
//  Prob+CoreDataProperties.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//
//

import Foundation
import CoreData


extension Prob {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prob> {
        return NSFetchRequest<Prob>(entityName: "Prob")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var headsProb: NSObject?
    @NSManaged public var tailsProb: NSObject?

}
