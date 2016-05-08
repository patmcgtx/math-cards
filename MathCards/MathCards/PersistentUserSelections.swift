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
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var defaultValue = defaults.integerForKey(userDefaultsFirstNumberMin)
        retval.firstNumberMin = defaultValue == 0 ? 1 : defaultValue
        
        defaultValue = defaults.integerForKey(userDefaultsFirstNumberMax)
        retval.firstNumberMax = defaultValue == 0 ? 10 : defaultValue
        
        defaultValue = defaults.integerForKey(userDefaultsSecondNumberMin)
        retval.secondNumberMin = defaultValue == 0 ? 1 : defaultValue
        
        defaultValue = defaults.integerForKey(userDefaultsSecondNumberMax)
        retval.secondNumberMax = defaultValue == 0 ? 10 : defaultValue
        
        retval.cardLimit = defaults.integerForKey(userDefaultsCardLimit)
        retval.minuteLimit = defaults.integerForKey(userDefaultsMinuteLimit)
        
        retval.mathOperation(MathOperation.Addition, shouldBeIncluded: defaults.boolForKey(userDefaultsMathOperationAddition))
        retval.mathOperation(MathOperation.Subtraction, shouldBeIncluded: defaults.boolForKey(userDefaultsMathOperationSubtraction))
        retval.mathOperation(MathOperation.Multiplication, shouldBeIncluded: defaults.boolForKey(userDefaultsMathOperationMultiplication))
        retval.mathOperation(MathOperation.Division, shouldBeIncluded: defaults.boolForKey(userDefaultsMathOperationDivision))
        
        if retval.mathOperations.isEmpty {
            retval.mathOperation(.Addition, shouldBeIncluded: true)
        }
        
        return retval
    }
    
    
    // Saves the given user selections to disk
    func save(userSelections : UserSelections) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(userSelections.firstNumberMin, forKey: userDefaultsFirstNumberMin)
        defaults.setInteger(userSelections.firstNumberMax, forKey: userDefaultsFirstNumberMax)
        defaults.setInteger(userSelections.secondNumberMin, forKey: userDefaultsSecondNumberMin)
        defaults.setInteger(userSelections.secondNumberMax, forKey: userDefaultsSecondNumberMax)
        
        if let tmpVal = userSelections.cardLimit {
            defaults.setInteger(tmpVal, forKey: userDefaultsCardLimit)
        }
        else {
            defaults.setInteger(0, forKey: userDefaultsCardLimit)
        }

        if let tmpVal2 = userSelections.minuteLimit {
            defaults.setInteger(tmpVal2, forKey: userDefaultsMinuteLimit)
        }
        else {
            defaults.setInteger(0, forKey: userDefaultsMinuteLimit)
        }

        defaults.setBool(userSelections.mathOperations.contains(MathOperation.Addition), forKey: userDefaultsMathOperationAddition)
        defaults.setBool(userSelections.mathOperations.contains(MathOperation.Subtraction), forKey: userDefaultsMathOperationSubtraction)
        defaults.setBool(userSelections.mathOperations.contains(MathOperation.Multiplication), forKey: userDefaultsMathOperationMultiplication)
        defaults.setBool(userSelections.mathOperations.contains(MathOperation.Division), forKey: userDefaultsMathOperationDivision)
        
        defaults.synchronize()
    }

    
    // MARK: Internal methods
    
    private var archiveFilePath : String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let documentsURL = NSURL.fileURLWithPath(documentsPath).URLByAppendingPathComponent("userSelections").URLByAppendingPathExtension("archive")
        return documentsURL.absoluteString
    }
    
    
    
    // MARK: Singleton stuff
    // http://code.martinrue.com/posts/the-singleton-pattern-in-swift
    
    class var sharedInstance: PersistentUserSelections {
        
        struct Static {
            static var instance: PersistentUserSelections?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = PersistentUserSelections()
        }
        
        return Static.instance!
    }
    
}