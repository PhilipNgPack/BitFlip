//
//  MoneySystem.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 9/6/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation
import CoreData

class MoneySystem {
    
    var coreDataManager: CoreDataManager?
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // flips the coin and sends the data to CoreData
    func updateBalance() {
        print("updating balance...")
    }
    
}
