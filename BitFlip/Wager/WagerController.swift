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
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.definesPresentationContext = true
    }

    //MARK: Actions
    @IBAction func acceptButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // add a function to accept the new wager
    }
   
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        // default to not changing the wager amount
    }
    
    

}
