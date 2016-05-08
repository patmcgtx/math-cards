//
//  HiddenCursorTextField.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/15/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class HiddenCursorNumericTextField : NumericTextField {
    
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRectZero
    }

    override func updateAppearance() {
        // Skip the visual customization in the parent class
    }
    
}
