//
//  MathHelperTestes.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit
import XCTest

class MathHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDivisor() {

        var divisor = MathHelper.bestCleanDivisorNear(10, divisor: 3, divisorMin: 1, divisorMax: 10)
        XCTAssert(divisor == 5, "10 / 3")

        divisor = MathHelper.bestCleanDivisorNear(10, divisor:9, divisorMin:1, divisorMax: 10)
        XCTAssert(divisor == 5, "10 / 9")

        divisor = MathHelper.bestCleanDivisorNear(22, divisor:21, divisorMin:1, divisorMax: 100)
        XCTAssert(divisor == 11, "22 / 21")

        divisor = MathHelper.bestCleanDivisorNear(22, divisor:21, divisorMin:1, divisorMax: 100)
        XCTAssert(divisor == 11, "22 / 21")
        
        divisor = MathHelper.bestCleanDivisorNear(22, divisor:21, divisorMin:1, divisorMax: 12)
        XCTAssert(divisor == 1, "22 / 21") // Returns 1 because divisor is out of min/maxrange

        divisor = MathHelper.bestCleanDivisorNear(71, divisor:71, divisorMin:1, divisorMax: 100)
        XCTAssert(divisor == 1, "71 / 71") // Returns 1 because divisor is prime

        divisor = MathHelper.bestCleanDivisorNear(1, divisor:1, divisorMin:1, divisorMax: 10)
        XCTAssert(divisor == 1, "1 / 1")

        divisor = MathHelper.bestCleanDivisorNear(100, divisor:6, divisorMin:1, divisorMax: 100)
        XCTAssert(divisor == 10, "100 / 6")
        
        divisor = MathHelper.bestCleanDivisorNear(100, divisor:6, divisorMin:1, divisorMax: 9)
        XCTAssert(divisor == 5, "100 / 6")
        
        divisor = MathHelper.bestCleanDivisorNear(14, divisor:8, divisorMin:1, divisorMax: 10)
        XCTAssert(divisor == 7, "14 / 8")

        divisor = MathHelper.bestCleanDivisorNear(6, divisor:-9, divisorMin:-10, divisorMax: 10)
        XCTAssert(divisor == -6, "6 / -9")

        divisor = MathHelper.bestCleanDivisorNear(9, divisor:-6, divisorMin:-10, divisorMax: 10)
        XCTAssert(divisor == -3, "9 / -6")

        divisor = MathHelper.bestCleanDivisorNear(-9, divisor:6, divisorMin:-10, divisorMax: 10)
        XCTAssert(divisor == 9, "-9 / 6")

        divisor = MathHelper.bestCleanDivisorNear(-9, divisor:6, divisorMin:-10, divisorMax: 8)
        XCTAssert(divisor == 3, "-9 / 6")
    }
    
}