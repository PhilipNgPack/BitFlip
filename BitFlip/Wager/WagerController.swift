//
//  wagerController.swift
//  BitFlip
//
//  Created by Philip Ng Pack on 8/30/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit

class WagerController: UIViewController {

    //MARK: Variables
    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.definesPresentationContext = true
    }

    
    @IBAction func amountButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // add a function to accept the new wager
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // default to not changing the wager amount
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        print("I am the minus button")
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        print("I am the plus button")
    }
    
}
