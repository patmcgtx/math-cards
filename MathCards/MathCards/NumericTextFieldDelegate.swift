//
//  NumericTextFieldDelegate.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/19/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class NumericTextFieldDelegate: NSObject, UITextFieldDelegate {
        
    func textField(textField:UITextField, shouldChangeCharactersInRange range:NSRange, replacementString replacement:String) -> Bool {
        
        var retval = true
        var proposedText = textField.text.stringByReplacingNSRange(range, withString: replacement)
        
        if let numericTextField = textField as? NumericTextField {
            retval = numericTextField.shouldAcceptEditingText(proposedText)
        }
        
        return retval
    }

    // This allow the Go/Return button the keyboard to function
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
        
}