//
//  StringExtensionTests.swift
//  MathCards
//
//  Created by Patrick McGonigle on 11/30/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit
import XCTest

class StringExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testStringSubstring() {
        
        var orig = "-999"
        var stripped = orig.stripSubstring("-")
        XCTAssert(stripped == "999", "Neg 999")

        orig = "999"
        stripped = orig.stripSubstring("-")
        XCTAssert(stripped == "999", "Plain 999")
    }
    
    func testSubstringReplacement() {
        
        let initializedMiddleName = "Albert R. Quinnery"
        let middleInitialRange = NSRange(location: 7, length: 2)
        let fullMiddleName = initializedMiddleName.stringByReplacing(middleInitialRange, withString: "Robert")
        XCTAssertEqual(fullMiddleName, "Albert Robert Quinnery")
    }

}
