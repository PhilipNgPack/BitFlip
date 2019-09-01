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
    
    var container: NSPersistentContainer?
    var context: NSManagedObjectContext
    
    init(container: NSPersistentContainer) {
        self.container = container
        self.context = container.viewContext
    }
    
    // fetches all the flips
    func fetchAllFlips() -> [Flip]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Flip")
        
        do {
            let flip = try context.fetch(fetchRequest)
            return flip as? [Flip]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    // adds a flip to the context manager and saves it
    func insertFlip(outcome: Int16, date : Date, coins : Int32, tailsProb: Double, headsProb: Double) -> Flip? {
        let entity = NSEntityDescription.entity(forEntityName: "Flip",
                                                in: context)!
        let flip = NSManagedObject(entity: entity,
                                   insertInto: context)
        flip.setValue(outcome, forKeyPath: "outcome")
        flip.setValue(date, forKeyPath: "date")
        flip.setValue(coins, forKey: "coins")
        flip.setValue(tailsProb, forKeyPath: "tailsProb")
        flip.setValue(headsProb, forKeyPath: "headsProb")
        
        save()
        return flip as? Flip
    }
    
    // returns the number of entries in the given entity
    func getCount(_ entity: String) -> Int {
        switch entity {
        case "Flip":
            do {
                let count = try context.count(for: NSFetchRequest(entityName: "Flip"))
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
            print("Enter Flip to fetch the count")
            return 0
        }
    }
    
    // MARK: - Core Data Saving support
    func save() {
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
