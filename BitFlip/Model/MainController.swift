//
//  MainController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentOffset.x = self.view.frame.size.width
        
        let graphController: GraphController = GraphController(nibName: "GraphController", bundle: nil)
        self.addChild(graphController)
        self.scrollView.addSubview(graphController.view)
        graphController.didMove(toParent: self)
        
        let gameController: GameController = GameController(nibName: "GameController", bundle: nil)
        self.addChild(gameController)
        self.scrollView.addSubview(gameController.view)
        gameController.didMove(toParent: self)
        
        let historyController: HistoryController = HistoryController(nibName: "HistoryController", bundle: nil)
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
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3,
                                             height: self.view.frame.size.height)
    }
    
    
}

