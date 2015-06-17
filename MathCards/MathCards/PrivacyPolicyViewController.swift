//
//  AboutViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 11/15/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController : UIViewController {
    
    override func viewDidLoad() {
        
        // Display the background image
        //self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg0"))
        //self.tableView.backgroundView?.contentMode = UIViewContentMode.ScaleAspectFill
        
    }
    
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
