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
    var wagerSystem: WagerSystem?
    
    init(coreDataManager: CoreDataManager, wagerSystem: WagerSystem) {
        self.coreDataManager = coreDataManager
        self.wagerSystem = wagerSystem
    }
    
    // updates the current balance
    func updateBalance() {
        print("updating balance...")
        wagerSystem?.printWager()
    }
    
}
