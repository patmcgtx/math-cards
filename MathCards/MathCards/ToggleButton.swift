//
//  ToggleButton.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/11/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

//
// This view shows a button which can be toggled on and off
//
class ToggleButton : UIButton {
    
    fileprivate var isActivatedInternal = false
    
    var selectedColor: UIColor = UIColor.black
    var deselectedColor: UIColor = UIColor.gray
    
    var selectedBorderWidth: CGFloat = 2.0
    var deselectedBorderWidth: CGFloat = 1.0

    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.borderColor = self.selectedColor.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
    }
    
    
    var activated: Bool {
        get {
            return self.isActivatedInternal
        }
        set(isActivated) {
            
            self.isActivatedInternal = isActivated
            
            if ( self.isActivatedInternal ) {
                self.setTitleColor(self.selectedColor, for: UIControlState())
                self.layer.borderColor = self.selectedColor.cgColor
                self.layer.borderWidth = self.selectedBorderWidth
            }
            else {
                self.setTitleColor(self.deselectedColor, for: UIControlState())
                self.layer.borderColor = self.deselectedColor.cgColor
                self.layer.borderWidth = self.deselectedBorderWidth
            }
        }
    }
    
    
    func toggle() -> Bool {
        self.activated = !self.activated
        return self.activated
    }
    
}
