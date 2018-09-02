//
//  SetupButton.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/24/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

/**
 A button on the setup screen which can be pressed to open a control item,
 e.g. for operator selection, number ranges, etc.
 
 These buttons are "exploded" into detailed detailed control views.
 */
class SetupControlButton : UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        
        super .init(coder: aDecoder)
        
        self.layer.borderWidth = AppStyle.SetupScreen.borderWidth
        self.layer.cornerRadius = AppStyle.SetupScreen.cornerRadius
        self.layer.borderColor = AppStyle.SetupScreen.borderColor.cgColor
        
        self.titleEdgeInsets = AppStyle.SetupScreen.edgeInsets
        self.setTitleColor(AppStyle.SetupScreen.fontColor, for: .normal)

        self.backgroundColor = AppStyle.SetupScreen.backgroundColor
    }
}
