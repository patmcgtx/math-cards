//
//  UserSelections.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/11/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

//
// This class tracks the user's options for the types of math questions to see
//
class UserSelections: NSObject {
    
    var firstNumberMin: Int = 1
    var firstNumberMax: Int = 10

    var secondNumberMin: Int = 1
    var secondNumberMax: Int = 10

    var cardLimit: Int? = 0
    var minuteLimit: Int? = 0
    
    
    // Next best thing to a Set, which Swift does not have (yet?)
    private var mathOperationsDict = [MathOperation: Bool]()
    
    var mathOperations: [MathOperation] {
        var retval = [MathOperation]()
            for (mathOp, isEnabled) in self.mathOperationsDict {
                if (isEnabled) {
                    retval.append(mathOp)
                }
            }
            return retval
    }
    
    
    func mathOperation(mathOp: MathOperation, shouldBeIncluded shouldInclude: Bool){
        
        self.mathOperationsDict[mathOp] = shouldInclude
        
        if (self.mathOperations.isEmpty) {
            NSNotificationCenter.defaultCenter().postNotificationName(notificationMathOpsEmpty, object: self)
        }
        else {
            NSNotificationCenter.defaultCenter().postNotificationName(notificationMathOpsNotEmpty, object: self)
        }
    }

}