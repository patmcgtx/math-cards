//
//  MathQuestion.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/12/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

//
// This class represents a math question such as 12 + 8
//
class MathQuestion: NSObject {
    
    var firstNumber: Int = 1
    var operation: MathOperation = .Addition
    var secondNumber: Int = 1

    
    init(first firstNum: Int, operation mathOperation:MathOperation, second secondNum: Int) {
        
        super.init()
        
        self.firstNumber = firstNum
        self.operation = mathOperation
        self.secondNumber = secondNum
    }
    
    
    var expectedAnswer: Int {
        
        var retval = 0
            
        switch self.operation {
            
        case MathOperation.Addition:
            retval = self.firstNumber + self.secondNumber
            
        case MathOperation.Subtraction:
            retval = self.firstNumber - self.secondNumber
            
        case MathOperation.Multiplication:
            retval = self.firstNumber * self.secondNumber
            
        case MathOperation.Division:
            retval = self.firstNumber / self.secondNumber
            
        default: ()
            
        }
            
        return retval
    }
    
    
    // Creates a random math question within the given parameters
    class func generateRandom(firstNumMin firstMin: Int, firstNumMax firstMax: Int,
        operations: [MathOperation],
        secondNumMin secondMin: Int, secondNumMax secondMax: Int) -> MathQuestion? {
        
        var retval: MathQuestion? = nil
        
        if operations.count > 0 {
            
            let randOperationIndex = Int.random(0...operations.count-1)
            let randOperation = operations[randOperationIndex]
            
            let randFirst = Int.random(firstMin...firstMax)
            let randSecond = Int.random(secondMin...secondMax)
            
            var first = randFirst
            var second = randSecond
            
            if randOperation == MathOperation.Division {
                // Avoid fractional answers, div by zero, etc.
                second = MathHelper.bestCleanDivisorNear(first, divisor: second, divisorMin: secondMin, divisorMax: secondMax)
            }
            
            retval = MathQuestion(first:first, operation:randOperation, second:second)
        }
        
        return retval
    }
    
}
