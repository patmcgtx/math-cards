//
//  StringExtension.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

extension String {
    
    func stringByReplacing(_ nsrange:NSRange, withString replacement:String ) -> String {
        let range = Range(nsrange, in: self)!
        return self.replacingCharacters(in: range, with: replacement)
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
