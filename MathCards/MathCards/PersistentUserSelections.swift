//
//  PersistentUserSelections.swift
//  MathCards
//
//  Created by Patrick McGonigle on 11/9/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

//
// Saves and loads UserSelections to the disk
//
class PersistentUserSelections : NSObject {
    
    static let shared = PersistentUserSelections()
    
    let userDefaultsFirstNumberMin = "firstNumberMin"
    let userDefaultsFirstNumberMax = "firstNumberMax"
    let userDefaultsSecondNumberMin = "secondNumberMin"
    let userDefaultsSecondNumberMax = "secondNumberMax"
    let userDefaultsCardLimit = "cardLimit"
    let userDefaultsMinuteLimit = "minuteLimit"
    let userDefaultsMathOperationAddition = "addition"
    let userDefaultsMathOperationSubtraction = "subtraction"
    let userDefaultsMathOperationMultiplication = "multiplication"
    let userDefaultsMathOperationDivision = "division"
    
    
    // Loads the saved user selections from disk
    func load() -> UserSelections {
        
        let retval = UserSelections()
        let defaults = UserDefaults.standard
        
        var defaultValue = defaults.integer(forKey: userDefaultsFirstNumberMin)
        retval.firstNumberMin = defaultValue == 0 ? 1 : defaultValue
        
        defaultValue = defaults.integer(forKey: userDefaultsFirstNumberMax)
        retval.firstNumberMax = defaultValue == 0 ? 10 : defaultValue
        
        defaultValue = defaults.integer(forKey: userDefaultsSecondNumberMin)
        retval.secondNumberMin = defaultValue == 0 ? 1 : defaultValue
        
        defaultValue = defaults.integer(forKey: userDefaultsSecondNumberMax)
        retval.secondNumberMax = defaultValue == 0 ? 10 : defaultValue
        
        retval.cardLimit = defaults.integer(forKey: userDefaultsCardLimit)
        retval.minuteLimit = defaults.integer(forKey: userDefaultsMinuteLimit)
        
        retval.mathOperation(MathOperation.Addition, shouldBeIncluded: defaults.bool(forKey: userDefaultsMathOperationAddition))
        retval.mathOperation(MathOperation.Subtraction, shouldBeIncluded: defaults.bool(forKey: userDefaultsMathOperationSubtraction))
        retval.mathOperation(MathOperation.Multiplication, shouldBeIncluded: defaults.bool(forKey: userDefaultsMathOperationMultiplication))
        retval.mathOperation(MathOperation.Division, shouldBeIncluded: defaults.bool(forKey: userDefaultsMathOperationDivision))
        
        if retval.mathOperations.isEmpty {
            retval.mathOperation(.Addition, shouldBeIncluded: true)
        }
        
        return retval
    }
    
    
    // Saves the given user selections to disk
    func save(_ userSelections : UserSelections) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(userSelections.firstNumberMin, forKey: userDefaultsFirstNumberMin)
        defaults.set(userSelections.firstNumberMax, forKey: userDefaultsFirstNumberMax)
        defaults.set(userSelections.secondNumberMin, forKey: userDefaultsSecondNumberMin)
        defaults.set(userSelections.secondNumberMax, forKey: userDefaultsSecondNumberMax)
        
        if let tmpVal = userSelections.cardLimit {
            defaults.set(tmpVal, forKey: userDefaultsCardLimit)
        }
        else {
            defaults.set(0, forKey: userDefaultsCardLimit)
        }

        if let tmpVal2 = userSelections.minuteLimit {
            defaults.set(tmpVal2, forKey: userDefaultsMinuteLimit)
        }
        else {
            defaults.set(0, forKey: userDefaultsMinuteLimit)
        }

        defaults.set(userSelections.mathOperations.contains(MathOperation.Addition), forKey: userDefaultsMathOperationAddition)
        defaults.set(userSelections.mathOperations.contains(MathOperation.Subtraction), forKey: userDefaultsMathOperationSubtraction)
        defaults.set(userSelections.mathOperations.contains(MathOperation.Multiplication), forKey: userDefaultsMathOperationMultiplication)
        defaults.set(userSelections.mathOperations.contains(MathOperation.Division), forKey: userDefaultsMathOperationDivision)
        
        defaults.synchronize()
    }

    
    // MARK: Internal methods
    
    fileprivate var archiveFilePath : String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let documentsURL = URL(fileURLWithPath: documentsPath).appendingPathComponent("userSelections").appendingPathExtension("archive")
        return documentsURL.absoluteString
    }
    
}
