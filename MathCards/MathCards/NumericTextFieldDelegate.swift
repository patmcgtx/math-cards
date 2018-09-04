//
//  NumericTextFieldDelegate.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/19/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class NumericTextFieldDelegate: NSObject, UITextFieldDelegate {
        
    func textField(_ textField:UITextField, shouldChangeCharactersIn range:NSRange, replacementString replacement:String) -> Bool {
        
        var retval = true
        let proposedText = textField.text!.stringByReplacing(range, withString: replacement)        
        
        if let numericTextField = textField as? NumericTextField {
            retval = numericTextField.shouldAcceptEditingText(proposedText)
        }
        
        return retval
    }

    // This allows the Go/Return button on the keyboard to function
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
        
}
