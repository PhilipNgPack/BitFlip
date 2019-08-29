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
    @IBOutlet weak var pageViewContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("the maincontroller loaded but I want the other to load too...")
        

//        // hide scroll bar 
//        scrollView?.showsHorizontalScrollIndicator = false
//
//        self.scrollView.contentSize = CGSize(width: frameWidth * 3,
//                                             height: frameWidth)
////        self.loadObservers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pagination",
            let pageView = segue.destination as? PageViewController {
            pageView.container = container
        }
    }
//    func loadObservers () {
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self,
//                                       selector: #selector(selectViewController(notification:)),
//                                       name: .selectVCNotif,
//                                       object: nil)
//    }
}




// Notification center variables
extension Notification.Name {
    static let selectVCNotif = Notification.Name("selectViewController")
    static let flipCoinNotif = Notification.Name("flipCoinNotif")
}


