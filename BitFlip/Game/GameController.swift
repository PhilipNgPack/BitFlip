//
//  GameController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit

@objc protocol NextScreenDelegate {
    func didTapButton(name: String)
}

class GameController: UIViewController {

    // MARK: Variables
    @IBOutlet weak var graphButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    var selectionDelegate: NextScreenDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    @IBAction func graphButtonTapped(_ sender: Any) {
        selectionDelegate.didTapButton(name: "graph")
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        selectionDelegate.didTapButton(name: "history")
    }
    
    
}
