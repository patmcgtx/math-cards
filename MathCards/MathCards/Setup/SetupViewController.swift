//
//  SetupViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/24/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

/**
 The initial view controller for setting up a run of the math cards.
 */
class SetupViewController : UIViewController {
        
    @IBOutlet weak var operatorsButton: SetupControlButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // TODO Make a case statement or something
        
        if segue.identifier == "operators-segue" {
            let expandingSegue = segue as? ExpandingSegue
            expandingSegue?.launchView = self.operatorsButton
        }
        
    }
    
}
