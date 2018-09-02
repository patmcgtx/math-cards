//
//  AppAStyle.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/26/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

/**
 Constant values for shared visuals such as colors, fonts, etc.
 */
struct AppStyle {
    
    /**
     Styles for the setup screen and sub-screens.
     */
    struct SetupScreen {
        
        /** The color of the background on the setup screens */
        static let backgroundColor = UIColor.white

        /** The color of the borders of setup buttons and containers */
        static let borderColor = UIColor(netHex: 0x4bade9)
        
        // TODO
        static let borderWidth : CGFloat = 5.0
        
        // TODO
        static let cornerRadius : CGFloat = 15.0
        
        // TODO
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        /** The font color on the setup screen */
        static let fontColor = UIColor(netHex: 0xea5061)
    }

}
