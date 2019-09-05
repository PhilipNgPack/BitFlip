//
//  wagerController.swift
//  BitFlip
//
//  Created by Philip Ng Pack on 8/30/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit

class WagerController: UIViewController {

    // MARK: - Outlet variables
    
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    // MARK: - Animation variables
    
    var buttonAnim: UIButton!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
    }
    
    /// Handles what happens when you press the amount button
    @IBAction func amountButtonTapped(_ sender: Any) {
        buttonAnim = amountButton
        boingAnimation()
        dismiss(animated: true, completion: nil)
        //TODO: - add a function to accept the new #imageLiteral(resourceName: "wagerCross.png")wager
    }
    
    /// Close the modal when tapping outside the modal
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // default to not changing the wager amount
    }
    
    /// Decrease the wager
    @IBAction func minusButtonTapped(_ sender: Any) {
        buttonAnim = minusButton
        boingAnimation()
        print("I am the minus button")
    }
    
    /// Increase the wager
    @IBAction func plusButtonTapped(_ sender: Any) {
        buttonAnim = plusButton
        boingAnimation()
        print("I am the plus button")
    }
}

// MARK: - Animations extension

extension WagerController {
    
    /// animation--button shrinks down, then expands past its size and back to it's orignal size
    func boingAnimation() {
        self.buttonAnim.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            self.buttonAnim.transform = CGAffineTransform.identity
        }, completion: nil )
        
    }
}
