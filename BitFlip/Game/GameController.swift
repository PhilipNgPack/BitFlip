//
//  GameController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit

//@objc protocol ScrollViewDelegate {
//    func didTapButton(controller: String)
//}

class GameController: UIViewController {

    // MARK: Variables
    @IBOutlet weak var graphButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var bitcoin: UIImageView!
//    var delegate: ScrollViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func graphButtonTapped(_ sender: Any) {
        let payload = ["controller" : "graph"]
        NotificationCenter.default.post(name: .selectVCNotif,
                                        object: nil,
                                        userInfo: payload)
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        let payload = ["controller" : "history"]
        NotificationCenter.default.post(name: .selectVCNotif,
                                        object: nil,
                                        userInfo: payload)
    }
    
    @IBOutlet weak var bitcoinTapped: UIImageView!
    
    
}
