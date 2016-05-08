//
//  NSRangeExtension.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

extension String {
    
    func stringByReplacingNSRange(nsrange:NSRange, withString replacement:String ) -> String {

        let startIndex = self.startIndex.advancedBy(nsrange.location)
        let endIndex = startIndex.advancedBy(nsrange.length)
        let swiftRange = (startIndex..<endIndex)
        
        return self.stringByReplacingCharactersInRange(swiftRange, withString: replacement)
    }
    

    func matches(pattern: String, options: NSRegularExpressionOptions) -> Bool {
        
        let regex = try? NSRegularExpression(pattern: pattern, options: options)
        return regex?.numberOfMatchesInString(self, options: [], range: NSMakeRange(0, self.utf16.count)) != 0
    }


    func stripSubstring(substringToStrip: String) -> String {
        
        let selfNSString = self as NSString
        let retval = selfNSString.stringByReplacingOccurrencesOfString(substringToStrip, withString: "")
        
        return retval
    }
    
}
