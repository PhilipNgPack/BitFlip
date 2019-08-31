//
//  AppDependencies.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/29/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation
import CoreData

struct AppDependencies {
    
    var coreDataManager: CoreDataManager
    var pageViewController: PageViewController
    var graphController: GraphController
    var gameController: GameController
    var historyController: HistoryController
    
    var barChart: BarChart
    var flipSystem: FlipSystem
    
    init() {
        coreDataManager = CoreDataManager(container: persistentContainer)
        pageViewController = PageViewController()
        graphController = GraphController(nibName: "GraphController", bundle: nil)
        gameController = GameController(nibName: "GameController", bundle: nil)
        historyController = HistoryController(nibName: "HistoryController", bundle: nil)
        
        // other classes
        barChart = BarChart(coreDataManager: coreDataManager)
        flipSystem = FlipSystem(coreDataManager: coreDataManager)
        
        // let's do some injection
        graphController.barChart = barChart
        gameController.flipSystem = flipSystem
        
        pageViewController.graphController = graphController
        pageViewController.gameController = gameController
        pageViewController.historyController = historyController
    }

     var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "BitFlip")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
