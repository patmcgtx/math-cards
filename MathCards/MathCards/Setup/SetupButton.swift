//
//  SetupButton.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/24/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

class SetupButton : UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        
        super .init(coder: aDecoder)
        
        self.layer.borderWidth = 5.0
        self.layer.cornerRadius = 15.0
        self.layer.borderColor = UIColor.MathCards.Setup.border.cgColor
        
        self.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.setTitleColor(UIColor.MathCards.Setup.font, for: .normal)

        self.backgroundColor = UIColor.MathCards.Setup.background
    }
}
