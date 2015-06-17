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

        let startIndex = advance(self.startIndex, nsrange.location)
        let endIndex = advance(startIndex, nsrange.length)
        let swiftRange = Range<String.Index>(start: startIndex, end: endIndex)
        
        return self.stringByReplacingCharactersInRange(swiftRange, withString: replacement)
    }
    

    func matches(pattern: String, options: NSRegularExpressionOptions = nil) -> Bool {
        
        let regex = NSRegularExpression(pattern: pattern, options: options, error: nil)
        return regex?.numberOfMatchesInString(self, options: nil, range: NSMakeRange(0, self.utf16Count)) != 0
    }


    func stripSubstring(substringToStrip: String) -> String {
        
        let selfNSString = self as NSString
        let retval = selfNSString.stringByReplacingOccurrencesOfString(substringToStrip, withString: "")
        
        return retval
    }
    
}
