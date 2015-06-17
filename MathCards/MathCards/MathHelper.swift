//
//  MathHelper.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

class MathHelper : NSObject {
    
    class func bestCleanDivisorNear(dividend:Int, divisor:Int, divisorMin:Int, divisorMax:Int) -> Int {
        
        // Avoid unseamly situations...
        if divisor < divisorMin || divisor > divisorMax {
            return 1
        }
        
        // Try counting up from the given divisor
        for divisorTry in divisor...divisorMax {
            if !contains([0,1,dividend], divisorTry) {
                if dividend % divisorTry == 0 {
                    return divisorTry
                }
            }
        }

        // Try counting down from the given divisor
        for divisorTry in reverse(divisorMin...divisor) {
            if !contains([0,1,dividend], divisorTry) {
                if dividend % divisorTry == 0 {
                    return divisorTry
                }
            }
        }
        
        return 1
    }
    
}