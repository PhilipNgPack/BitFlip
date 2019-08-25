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
    @IBOutlet weak var bitcoinButton: UIButton!
    
//    var delegate: ScrollViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bounceAnim()
    }
    
    func bounceAnim() {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [.repeat, .autoreverse, .beginFromCurrentState],
                       animations: {
                        self.bitcoinButton.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(5))
                        self.bitcoinButton.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(-5))
        }, completion: nil)
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

    @IBAction func bitcoinButtonTapped(_ sender: Any) {
        
    }
    
    
}
