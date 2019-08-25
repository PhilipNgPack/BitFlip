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
    
    // fetches all the flips
    func fetchAllFlips(context: NSManagedObjectContext) -> [Flip]? {
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
    func fetchAllProbs(context: NSManagedObjectContext) -> [Prob]? {
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
    func insertFlip(context: NSManagedObjectContext, outcome: Int16, date : Date) -> Flip? {
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
    func insertProb(context: NSManagedObjectContext, headsProb: Double, tailsProb: Double, date : Date) -> Prob? {
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
    func getCount(context: NSManagedObjectContext, _ entity: String) -> Int {
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
    func save(context: NSManagedObjectContext) {
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
