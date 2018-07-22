//
//  IntExtensionsTests.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit
import XCTest

class IntExtensionsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRandom() {
        
        let lower = 1
        let upper = 10
        var allInRange = true

        // Try 100 random numbers and check their range
        for _ in 1...100 {
            
            let rand = Int.random(lower..<upper+1)
            print("\(rand)")
            
            let inRange = rand >= lower && rand <= upper
            if !inRange {
                allInRange = false
            }
            
        }
        XCTAssert(allInRange, "Pass")
        
    }
    
}
