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
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // TODO Make a case statement or something
        
        // if segue.identifier == "operators-segue"
        if let explosingSegue = segue as? ExplodingSegue {
            explosingSegue.launchView = self.operatorsButton
        }
        
    }
    
    // Used the IB "Exit" button to trigger this method to leaving the VC via segue
    @IBAction func unwind(segue: UIStoryboardSegue) {
        // This method handles data transfer when closing a sub-control / exploded view,
        // while ImpodingSegue handles the visuals / animation.
    }
    
}
