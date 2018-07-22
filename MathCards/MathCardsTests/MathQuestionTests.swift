//
//  MathQuestionTests.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit
import XCTest

class MathQuestionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreation() {

        let sub = MathQuestion(first:10, operation:.Subtraction, second:1)
        XCTAssert(sub.firstNumber == 10, "Subtraction first")
        XCTAssert(sub.operation == MathOperation.Subtraction, "Subtraction operation")
        XCTAssert(sub.secondNumber == 1, "Subtraction second")
        XCTAssert(sub.expectedAnswer == 9, "Subtraction answer")

        let add = MathQuestion(first:3, operation:.Addition, second:2)
        XCTAssert(add.firstNumber == 3, "Addition first")
        XCTAssert(add.operation == MathOperation.Addition, "Addition operation")
        XCTAssert(add.secondNumber == 2, "Addition second")
        XCTAssert(add.expectedAnswer == 5, "Addition answer")

        let mult = MathQuestion(first:7, operation:.Multiplication, second:6)
        XCTAssert(mult.firstNumber == 7, "Multiplication first")
        XCTAssert(mult.operation == MathOperation.Multiplication, "Multiplication operation")
        XCTAssert(mult.secondNumber == 6, "Multiplication second")
        XCTAssert(mult.expectedAnswer == 42, "Multiplication answer")

        let div = MathQuestion(first:8, operation:.Division, second:2)
        XCTAssert(div.firstNumber == 8, "Division first")
        XCTAssert(div.operation == MathOperation.Division, "Division operation")
        XCTAssert(div.secondNumber == 2, "Division second")
        XCTAssert(div.expectedAnswer == 4, "Division answer")
    }
    
    func testRandomGeneration() {
        
        // Try 100 random math questions
        for _ in 1...100 {
            
            let minNum = 1
            let maxNum = 10
            let ops = [MathOperation.Addition, MathOperation.Subtraction]
            let randQuestion = MathQuestion.generateRandom(firstNumMin: minNum, firstNumMax: maxNum, operations: ops, secondNumMin: minNum, secondNumMax: maxNum);
            
            XCTAssert(randQuestion!.firstNumber >= minNum, "Random first floor")
            XCTAssert(randQuestion!.firstNumber <= maxNum, "Random first ceiling")
            XCTAssert(ops.contains(randQuestion!.operation), "Random second operation")
            XCTAssert(randQuestion!.secondNumber >= minNum, "Random second floor")
            XCTAssert(randQuestion!.secondNumber <= maxNum, "Random second ceiling")
        }
    }
    
}
