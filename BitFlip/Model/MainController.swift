//
//  MainController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit
import CoreData

class MainController: UIViewController {
    
    // MARK: Variables
    var container: NSPersistentContainer!
    var graphController: GraphController!
    var gameController: GameController!
    var historyController: HistoryController!
    @IBOutlet weak var pageViewContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pagination",
            let pageView = segue.destination as? PageViewController {
            pageView.graphController = graphController
            pageView.gameController = gameController
            pageView.historyController = historyController
        }
    }
}

// Notification center variables
extension Notification.Name {
    static let goToPageNotif = Notification.Name("goToPageNotif")
    static let flipCoinNotif = Notification.Name("flipCoinNotif")
}


