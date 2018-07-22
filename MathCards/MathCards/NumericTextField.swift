//
//  IntegerTextField.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/11/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


//
// This view shows a text fielf which only accepts digits and additional validations
//
class NumericTextField: UITextField {
    
    fileprivate var lastSavedValue: String!
    
    var maxNumDigits: Int? = 3
    var allowsEmptyValue = false
    
    var ceilingTextField: NumericTextField?
    var floorTextField: NumericTextField?
    
    var floorValue: Int?
    var ceilingValue: Int?
    
    var selectedColor: UIColor = UIColor.black
    var deselectedColor: UIColor = UIColor.gray

    
    // MARK: Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.lastSavedValue = self.text
        self.updateAppearance()
    }
    

    // MARK: Delegate methods
    
    func shouldAcceptEditingText(_ proposedValue: String) -> Bool {
        
        // Always allow the field to be empty or '-' (at least temporarily) for editing
        var retval = proposedValue.isEmpty || proposedValue == "-"
        
        if ( !retval ) {
            
            // For non-empty text, check for numeric value and length
            let lengthOkay = proposedValue.replacingOccurrences(of: "-", with: "").characters.count <= self.maxNumDigits
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
            self.layer.borderColor = self.deselectedColor.cgColor
            self.layer.borderWidth = 1.0
        }
        else {
            self.layer.borderColor = self.selectedColor.cgColor
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
        self.layer.borderColor = UIColor.red.cgColor
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(NumericTextField.updateAppearance), userInfo: nil, repeats: false)
    }
    
}
