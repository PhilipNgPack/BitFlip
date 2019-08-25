//
//  MainController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    // MARK: Variables
    @IBOutlet weak var scrollView: UIScrollView!
    var graphController: GraphController!
    var gameController: GameController!
    var historyController: HistoryController!
    var viewControllers: [String] = ["graph", "game", "history"]
    
    // MARK: Numbered variables
    var frameWidth:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadObservers()
        
        frameWidth = self.view.frame.size.width
        scrollView.contentOffset.x = frameWidth
        
        graphController = GraphController(nibName: "GraphController", bundle: nil)
        self.addChild(graphController)
        self.scrollView.addSubview(graphController.view)
        graphController.didMove(toParent: self)
        
        gameController = GameController(nibName: "GameController", bundle: nil)
        self.addChild(gameController)
        self.scrollView.addSubview(gameController.view)
        gameController.didMove(toParent: self)

        
        historyController = HistoryController(nibName: "HistoryController", bundle: nil)
        self.addChild(historyController)
        self.scrollView.addSubview(historyController.view)
        historyController.didMove(toParent: self)
        
        var gameFrame: CGRect = gameController.view.frame
        gameFrame.origin.x = self.view.frame.width
        gameController.view.frame = gameFrame
        
        var historyFrame: CGRect = historyController.view.frame
        historyFrame.origin.x = 2 * self.view.frame.width
        historyController.view.frame = historyFrame
        
        // hide scroll bar
        scrollView?.showsHorizontalScrollIndicator = false
        
        self.scrollView.contentSize = CGSize(width: frameWidth * 3,
                                             height: frameWidth)
    }
    
    func loadObservers () {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(selectViewController(notification:)),
                                       name: .selectVCNotif,
                                       object: nil)
    }
    
    // finds the index of a ViewController
    func indexFor(controller: String?) -> Int? {
        return viewControllers.firstIndex(of: controller! )
    }
    
    @objc func selectViewController(notification: NSNotification) {
        if let controller = notification.userInfo?["controller"] as? String {            
            guard let index = indexFor(controller: controller) else { return }
            let offset = CGPoint(x: frameWidth * CGFloat(index), y:0.0)
            scrollView.setContentOffset(offset, animated: true)
        }
    }
}

//extension MainController: ScrollViewDelegate {
//
//    // go to the selected ViewController
//    func didTapButton(controller: String) {
//        guard let index = indexFor(controller: controller) else { return }
//        let offset = CGPoint(x: frameWidth * CGFloat(index), y:0.0)
//        scrollView.setContentOffset(offset, animated: true)
//    }
//}

// Notification center variables
extension Notification.Name {
    static let selectVCNotif = Notification.Name("selectViewController")
}



