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
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.blue.cgColor
        self.setTitleColor(UIColor.blue, for: .normal)
        self.backgroundColor = UIColor.white
    }
}
