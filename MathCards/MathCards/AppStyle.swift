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
    
    struct Animations {
        
        struct Expand {
            static let duration = 0.25
        }
        
    }
    
    struct SetupScreen {
        
        struct Border {
            static let color = UIColor(netHex: 0x4bade9)
            static let width : CGFloat = 5.0
            static let corner : CGFloat = 15.0
            static let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        struct Background {
            static let color = UIColor.white
        }
        
        struct Font {
            static let color = UIColor(netHex: 0xea5061)
        }
    }

}
