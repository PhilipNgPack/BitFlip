//
//  LineChart.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 9/2/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation

class LineChart {
    
    //MARK: - Dependency injection variable
    var coreDataManager: CoreDataManager
    
    //MARK: - Initialization
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
}
