//
//  NumericTextFieldDelegate.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/10/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

//
// This delegate supports the numeric text fields in the run-cards view
//
class RunCardsTextFieldDelegate: NumericTextFieldDelegate {
    
    fileprivate weak var runCardsViewController: RunCardsViewController?
    
    init(runCardsVC: RunCardsViewController) {
        self.runCardsViewController = runCardsVC
    }
    
    // This is called when the Go/Return button is pushed
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Submit the answer
        self.runCardsViewController?.answerSubmitted(self)
        
        // Prevent the keyboard from going away
        return false
    }
    
}
