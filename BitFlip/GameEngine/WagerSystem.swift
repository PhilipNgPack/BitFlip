//
//  WageSystem.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 9/6/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation

import Foundation
import CoreData

class WagerSystem {
    
    var coreDataManager: CoreDataManager?
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // updates the current balance
    func printWager() {
        print("This is the wager system")
        
    }
    
}
