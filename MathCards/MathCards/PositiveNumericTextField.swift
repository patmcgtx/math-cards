//
//  PositiveNumericTextField.swift
//  MathCards
//
//  Created by Patrick McGonigle on 11/22/14.
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


class PositiveNumericTextField : NumericTextField {

    override func revertTextIfInvalid() {

        super.revertTextIfInvalid()
        
        if self.intValue < 1 {
            self.text = ""
        }
    }
    
}
