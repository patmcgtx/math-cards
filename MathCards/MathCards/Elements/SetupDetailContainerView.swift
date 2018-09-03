//
//  SetupDetailContainerView.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/26/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

/**
 A base view to contain individual setup controls, e.g. operator selection, number ranges, etc.
 Buttons on the main screen are "exploded" into a control contained in this view.
 */
class SetupDetailContainerView : UIView {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius = 30.0
        self.layer.borderColor = AppStyle.SetupScreen.Border.color.cgColor
        
        self.backgroundColor = AppStyle.SetupScreen.Background.color
    }
    
}
