//
//  PositiveNumericTextField.swift
//  MathCards
//
//  Created by Patrick McGonigle on 11/22/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class PositiveNumericTextField : NumericTextField {

    override func revertTextIfInvalid() {

        super.revertTextIfInvalid()
        
        if self.intValue < 1 {
            self.text = ""
        }
    }
    
}
