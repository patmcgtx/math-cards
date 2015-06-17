//
//  PurchaseAllMathOperationsController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/26/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class PurchaseAllMathOperationsController : UIViewController {

    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        
        self.cardView.layer.cornerRadius = 5
        self.cardView.layer.borderColor = UIColor.blackColor().CGColor
        self.cardView.layer.borderWidth = 2.0
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPurchaseGesture(sender: AnyObject) {
    }
    
}
