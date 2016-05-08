//
//  IntegerTextField.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/11/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

//
// This view shows a text fielf which only accepts digits and additional validations
//
class NumericTextField: UITextField {
    
    private var lastSavedValue: String!
    
    var maxNumDigits: Int? = 3
    var allowsEmptyValue = false
    
    var ceilingTextField: NumericTextField?
    var floorTextField: NumericTextField?
    
    var floorValue: Int?
    var ceilingValue: Int?
    
    var selectedColor: UIColor = UIColor.blackColor()
    var deselectedColor: UIColor = UIColor.grayColor()

    
    // MARK: Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.lastSavedValue = self.text
        self.updateAppearance()
    }
    

    // MARK: Delegate methods
    
    func shouldAcceptEditingText(proposedValue: String) -> Bool {
        
        // Always allow the field to be empty or '-' (at least temporarily) for editing
        var retval = proposedValue.isEmpty || proposedValue == "-"
        
        if ( !retval ) {
            
            // For non-empty text, check for numeric value and length
            let lengthOkay = proposedValue.stringByReplacingOccurrencesOfString("-", withString: "").characters.count <= self.maxNumDigits
            var numericOkay = false
            
            if (Int(proposedValue) != nil) {
                numericOkay = true
            }
            
            retval = lengthOkay && numericOkay
        }
        
        return retval
    }

    
    // MARK: Calculated properties
    
    var intValue: Int? {
        
        set(updatedValue) {
            if let updatedIntVal: Int = updatedValue {
                if updatedIntVal == 0 && self.allowsEmptyValue {
                    self.text = ""
                }
                else {
                    self.text = String(updatedIntVal)
                }
            }
            self.updateAppearance()
        }
        get {
            if let retval = Int(self.text!) {
                return retval
            }
            else {
                return nil
            }
        }
    }
    
    
    // MARK: Other methods
    
    func revertTextIfInvalid() {
                
        var updatedTextIsOkay = false
        
        if self.text!.isEmpty {
            updatedTextIsOkay = self.allowsEmptyValue
        }
        else {
            var ceilingOkay = true
            var floorOkay = true
            
            if let updatedIntValue = self.intValue {
                
                if let ceiling = self.ceilingTextField {
                    ceilingOkay = updatedIntValue <= ceilingTextField?.intValue
                    if ( !ceilingOkay ) {
                        ceiling.temporarilyHighlight()
                    }
                }

                if ceilingOkay {
                    if let ceiling2 = self.ceilingValue {
                        ceilingOkay = updatedIntValue <= ceiling2
                    }
                }
                
                if let floor = self.floorTextField {
                    floorOkay = updatedIntValue >= floorTextField?.intValue
                    if ( !floorOkay ) {
                        floor.temporarilyHighlight()
                    }
                }

                if floorOkay {
                    if let floor2 = self.floorValue {
                        floorOkay = updatedIntValue >= floor2
                    }
                }
                
                updatedTextIsOkay = ceilingOkay && floorOkay
            }
            else {
                updatedTextIsOkay = false
            }
            
        }
        
        if updatedTextIsOkay {
            self.lastSavedValue = self.text
        }
        else {
            self.text = self.lastSavedValue
        }
    }
    
    
    func updateAppearance() {
        
        if ( self.text!.isEmpty ) {
            self.layer.borderColor = self.deselectedColor.CGColor
            self.layer.borderWidth = 1.0
        }
        else {
            self.layer.borderColor = self.selectedColor.CGColor
            self.layer.borderWidth = 2.0
        }
    }
    
    
    func invertValue() {
        
        if var numericValue = Int(self.text!) {
            numericValue = numericValue * -1
            self.text = String(numericValue)
        }
    }
    
    
    func temporarilyHighlight() {
        self.layer.borderColor = UIColor.redColor().CGColor
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(NumericTextField.updateAppearance), userInfo: nil, repeats: false)
    }
    
}
