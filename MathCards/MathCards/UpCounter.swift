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
    
    private var goal: Int?
    private var currentCount: Int = 1
    
    
    func reset(newGoal: Int?) {
        
        self.currentCount = 1
        self.goal = newGoal
        
        self.updateText()
    }
    
    
    func increment() {
        
        self.currentCount++
        self.updateText()
        
        if ( self.goal > 0 && self.currentCount > self.goal ) {
            self.delegate?.countUpDidFinish()
        }
    }
    
    
    private func updateText() {
        
        if ( self.goal < 1 ) {
            self.text = "\(self.currentCount)"
        }
        else {
            self.text = "\(self.currentCount) of \(self.goal!)"
        }
    }
    
}

