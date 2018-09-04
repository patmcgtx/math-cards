//
//  IntExtensions.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

extension Int {
    
    // http://stackoverflow.com/questions/24132399/how-does-one-make-random-number-between-range-for-arc4random-uniform
    
    static func random(_ range: Range<Int> ) -> Int {

        var offset = 0
        
        if range.lowerBound < 0 {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
}
