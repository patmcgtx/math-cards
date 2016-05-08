//
//  NumericTextFieldDelegate.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/10/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

//
// This delegate supports the numeric text fields in the user selctions view
//
class UserSelectionsTextFieldDelegate: NumericTextFieldDelegate {

    var maxNumDigits: Int = 3
    weak var userSelections: UserSelections?
    
    
    init(userSelections:UserSelections) {
        self.userSelections = userSelections
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if let numericTextField = textField as? NumericTextField {
            
            numericTextField.revertTextIfInvalid()
            numericTextField.updateAppearance()
            
            let textFieldIntValue = numericTextField.intValue
            
            switch ( numericTextField.tag ) {
                
            case tagForFirstNumberMinTextField:
                self.userSelections?.firstNumberMin = textFieldIntValue!
                
            case tagForFirstNumberMaxTextField:
                self.userSelections?.firstNumberMax = textFieldIntValue!
                
            case tagForSecondNumberMinTextField:
                self.userSelections?.secondNumberMin = textFieldIntValue!
                
            case tagForSecondNumberMaxTextField:
                self.userSelections?.secondNumberMax = textFieldIntValue!
                
            case tagForNumCardsTextField:
                self.userSelections?.cardLimit = textFieldIntValue
                
            case tagForNumMinutesTextField:
                self.userSelections?.minuteLimit = textFieldIntValue
                
            default: ()
            }
        }
    }
    
    
    override func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
