//
//  ColorExtensions.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/26/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

extension UIColor {
    
    //
    // MARK: Convenience hex init
    // From (https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6)
    //

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
}
