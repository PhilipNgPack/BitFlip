//
//  GameController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    // MARK: Outlet Variables
    
    @IBOutlet weak var graphButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var bitcoinButton: UIButton!
    var bitCoinPhases: [UIImage] = []
    
    // MARK: Dependency injection
    var flipSystem: FlipSystem?
    
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        bounceAnim()
        loadTextures()
    }
    
    @IBAction func graphButtonTapped(_ sender: Any) {
        let payload = ["page" : "graph"]
        NotificationCenter.default.post(name: .goToPageNotif,
                                        object: nil,
                                        userInfo: payload)
    }
    
    @IBAction func historyButtonTapped(_ sender: Any) {
        let payload = ["page" : "history"]
        NotificationCenter.default.post(name: .goToPageNotif,
                                        object: nil,
                                        userInfo: payload)
    }

    @IBAction func bitcoinButtonTapped(_ sender: Any) {
        flipCoinAnim()
        flipSystem?.flipCoin()
    }
    
    //MARK: Animations
    
    // load the animation textures for coin flipping
    func loadTextures() {
        for i in 1...8 {
            self.bitCoinPhases.append(UIImage(named: "bitcoin\(i)")!)
        }
    }
    
    // bouncing animations for the coin
    func bounceAnim() {
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       options: [.repeat, .autoreverse, .beginFromCurrentState,
                                 .allowUserInteraction],
                       animations: {
                        self.bitcoinButton.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(5))
                        self.bitcoinButton.transform = CGAffineTransform(translationX: CGFloat(0), y: CGFloat(-5))
        }, completion: nil)
    }
    
    // flipping animation for the coin
    func flipCoinAnim() {
        let animDuration: Double = 0.5
        self.view.isUserInteractionEnabled = false;
        bitcoinButton.imageView?.animationImages = bitCoinPhases
        bitcoinButton.imageView?.animationDuration = animDuration
        bitcoinButton.imageView?.animationRepeatCount = 1
        bitcoinButton.imageView!.startAnimating()
        
        // disable all user interaction until animation is complete
        DispatchQueue.main.asyncAfter(deadline: .now() + animDuration) {
            self.bitcoinButton.imageView!.stopAnimating()
            self.view.isUserInteractionEnabled = true;
        }
    }
}


