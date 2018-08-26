//
//  SetupDetailContainerView.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/26/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

class SetupDetailContainerView : UIView {
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius = 30.0
        self.layer.borderColor = UIColor.MathCards.Setup.border.cgColor
        
        self.backgroundColor = UIColor.MathCards.Setup.background
    }
    
}
