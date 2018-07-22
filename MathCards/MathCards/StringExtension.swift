//
//  StringExtension.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

extension String {

    //-------------------------------
    //
    // TODO: The follow methods should be able to go away in Swift 4
    //
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
    
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location + nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
    //
    //-------------------------------
    
    func stringByReplacing(_ nsrange:NSRange, withString replacement:String ) -> String {
        // TODO: This is a Swift 2->3 fix; see this page for a much simpler Swift 4 approach:
        // https://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index#
        let range = self.range(from: nsrange)
        return self.replacingCharacters(in: range!, with: replacement)
    }
    

    func matches(_ pattern: String, options: NSRegularExpression.Options) -> Bool {
        
        let regex = try? NSRegularExpression(pattern: pattern, options: options)
        return regex?.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.utf16.count)) != 0
    }


    func stripSubstring(_ substringToStrip: String) -> String {
        
        let selfNSString = self as NSString
        let retval = selfNSString.replacingOccurrences(of: substringToStrip, with: "")
        
        return retval
    }
    
}
