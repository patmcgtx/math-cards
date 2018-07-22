//
//  CountdownTimer.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/16/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

//
// This view shows a timer which counts down every second
//
class CountdownTimer: UILabel {

    // MARK: Public instance vars

    weak var delegate: CountdownDelegate?
    
    
    // MARK: Private instance vars
    
    fileprivate var secondsLeft: Int = 0
    fileprivate var countdownSeconds: Int?
    fileprivate var timer: Timer?
    fileprivate let tickSelector: Selector = #selector(CountdownTimer.tick)
    
    
    // MARK: Lifecycle
    
    deinit {
        self.timer?.invalidate()
    }

    
    // MARK: Public methods
    
    func setCountdown(minutes numMins: Int) {
        
        self.countdownSeconds = numMins * 60
        self.secondsLeft = numMins * 60
        
        self.text = self.secondsAsString(self.countdownSeconds)

        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
            selector: self.tickSelector, userInfo: nil, repeats: true)
    }
    
    
    func stop() {
        self.timer?.invalidate()
    }
    
    
    func tick() {
        
        self.text = self.secondsAsString(self.secondsLeft)
        self.secondsLeft -= 1
        
        if ( self.secondsLeft < 1 ) {
            self.stop()
            self.delegate?.countdownDidFinish()
        }
    }

    
    func timeCountedDownAsSeconds() -> Int? {
        
        var retval: Int? = nil
        
        if let countdownSecsNonNil = self.countdownSeconds {
            retval = countdownSecsNonNil - self.secondsLeft
        }
        
        return retval
    }

    
    func timeCountedDownAsString() -> String? {
        return self.secondsAsString(self.timeCountedDownAsSeconds())
    }
    
    
    // MARK: Private methods
    
    fileprivate func secondsAsString(_ seconds: Int?) -> String? {
        
        var retval: String? = ""
        
        if let secsNonNil = seconds {
            
            let min: Int = secsNonNil / 60
            let sec: Int = secsNonNil % 60
            
            retval = String(format: "%02i:%02i", min, sec)
        }
        
        return retval
    }
    
}
