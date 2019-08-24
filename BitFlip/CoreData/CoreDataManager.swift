//
//  CoreDataManager.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    // MARK: - Core Data stack
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
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
    
    // fetches all the flips
    func fetchAllFlips() -> [Flip]? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Flip")
        
        do {
            let flip = try context.fetch(fetchRequest)
            return flip as? [Flip]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // fetches all the probs
    func fetchAllProbs() -> [Prob]? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Prob")
        
        do {
            let prob = try context.fetch(fetchRequest)
            return prob as? [Prob]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // adds a flip to the context manager and saves it
    func insertFlip(outcome: Int16, date : Date) -> Flip? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Flip",
                                                in: context)!
        let flip = NSManagedObject(entity: entity,
                                   insertInto: context)
        flip.setValue(outcome, forKeyPath: "outcome")
        flip.setValue(date, forKeyPath: "date")
        
        do {
            try context.save()
            return flip as? Flip
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // adds a prob to the context manager and saves it
    func insertProb(headsProb: Double, tailsProb: Double, date : Date) -> Prob? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Prob",
                                                in: context)!
        let prob = NSManagedObject(entity: entity,
                                   insertInto: context)
        prob.setValue(headsProb, forKeyPath: "headsProb")
        prob.setValue(tailsProb, forKeyPath: "tailsProb")
        prob.setValue(date, forKeyPath: "date")
        
        do {
            try context.save()
            return prob as? Prob
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // returns the number of entries in the given entity
    func getCount(_ entity: String) -> Int {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        switch entity {
        case "Flip":
            do {
                let count = try context.count(for: NSFetchRequest(entityName: "Flip"))
                return count
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                return 0
            }
        case "Prob":
            do {
                let count = try context.count(for: NSFetchRequest(entityName: "Prob"))
                return count
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                return 0
            }
        case "headsCount":
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flip")
                fetchRequest.predicate = NSPredicate(format: "outcome == %@", 0)
                let count = try context.count(for: fetchRequest)
                return count
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                return 0
            }
            
        default:
            print("Enter Flip or Prob to fetch the count")
            return 0
        }
    }
    
    // MARK: - Core Data Saving support
    func save() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
