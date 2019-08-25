//
//  FlipSystem.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation
import CoreData

class FlipSystem {

    var coreDataManager: CoreDataManager?
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // flips the coin and sends the data to CoreData
    func flipCoin(context: NSManagedObjectContext) {
        let coinToss = Int.random(in: 0...1)
        coreDataManager?.save(context: context)
        print(coinToss)
    }
    
    
}
