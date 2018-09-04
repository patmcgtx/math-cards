//
//  UpCounter.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/15/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

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
        
        let goalVal = self.goal ?? 0
        
        if ( goalVal > 0 && self.currentCount > goalVal ) {
            self.delegate?.countUpDidFinish()
        }
    }
    
    
    fileprivate func updateText() {
        
        let goalVal = self.goal ?? 0
        
        if ( goalVal < 1 ) {
            self.text = "\(self.currentCount)"
        }
        else {
            self.text = "\(self.currentCount) of \(goalVal)"
        }
    }
    
}

