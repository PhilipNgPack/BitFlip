//
//  Flip+CoreDataProperties.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
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

}
