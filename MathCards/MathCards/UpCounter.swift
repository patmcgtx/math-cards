//
//  UpCounter.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/15/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


// 
// This view counts up from 1 to a given goal.
// Or if there is no goal, it just keeps counting up.
//
class UpCounter : UILabel {
    
    weak var delegate: UpCounterDelegate?
    
    fileprivate var goal: Int?
    fileprivate var currentCount: Int = 1
    
    
    func reset(_ newGoal: Int?) {
        
        self.currentCount = 1
        self.goal = newGoal
        
        self.updateText()
    }
    
    
    func increment() {
        
        self.currentCount += 1
        self.updateText()
        
        if ( self.goal > 0 && self.currentCount > self.goal ) {
            self.delegate?.countUpDidFinish()
        }
    }
    
    
    fileprivate func updateText() {
        
        if ( self.goal < 1 ) {
            self.text = "\(self.currentCount)"
        }
        else {
            self.text = "\(self.currentCount) of \(self.goal!)"
        }
    }
    
}

