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

    // fetches all the Flip objects
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
    
    // fetches all the outcomes for the inputted duration
    func fetchOutcomes(range: Int) -> [String: Int] {
        let end = Date()
        let start = Calendar.current.date(byAdding: DateComponents(day: -range), to: end)!
        
        let headsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flip")
        headsRequest.predicate = NSPredicate(format: "date > %@ AND date <= %@ AND outcome == %@",
                                        argumentArray: [start, end, 0])
        headsRequest.resultType = .countResultType
        
        let tailsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Flip")
        tailsRequest.predicate = NSPredicate(format: "date > %@ AND date <= %@ AND outcome == %@",
                                             argumentArray: [start, end, 1])
        tailsRequest.resultType = .countResultType
        
        let heads = try! context.fetch(headsRequest)[0] as! Int
        let tails = try! context.fetch(tailsRequest)[0] as! Int
        
        return ["heads": heads, "tails": tails]
    }
    
    func fetchProbs(period: String) {
        
//            let end = Date()
//            let start = Calendar.current.date(byAdding: DateComponents(day: -2), to: end)!
//
//            let keypathExp1 = NSExpression(forKeyPath: "outcome")
//            let expression = NSExpression(forFunction: "sum:", arguments: [keypathExp1])
//            let sumDesc = NSExpressionDescription()
//
//            sumDesc.expression = expression
//            sumDesc.name = "sum" // modifies the dictionary key
//            sumDesc.expressionResultType = .integer64AttributeType
//
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Flip")
//
//            request.predicate = NSPredicate(format: "date > %@ AND date <= %@",
//                                            argumentArray: [start, end])
//
//            request.returnsObjectsAsFaults = false
//            request.propertiesToFetch = [sumDesc]
//            request.resultType = .dictionaryResultType
//
//            let results = try! context.fetch(request) as! [NSDictionary]
//
//            for value in results {
//                print(value)
//            }
//            print(getCount("Flip"))
//
    }
    
    // fetches all the flips for the last 24 hours
    
    // adds a flip to the context manager and saves it
    func insertFlip(outcome: Int16, date : Date, coins : Int32) -> Flip? {
        let allOutcomes = fetchOutcomes(range: 1000)
        var heads = allOutcomes["heads"]!
        var tails = allOutcomes["tails"]!
        let total = heads + tails
        
        if outcome == 0 {
            heads += 1
        }
        else {
            tails += 1
        }
        let headsProb = heads/total
        let tailsProb = tails/total
        
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
