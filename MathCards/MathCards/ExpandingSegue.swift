//
//  SetupToDetailSegue.swift
//  MathCards
//
//  Created by Patrick McGonigle on 9/2/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

/**
 A segue that animates an expansion from a "launch" view to the full destination view controller
 */
class ExpandingSegue : UIStoryboardSegue {
    
    /** The view from which to "launch" the expansion animation */
    var launchView: UIView? = nil
    
    override func perform() {
        
        self.source.view.addSubview(self.destination.view)
        
        // Before doing the animation, record the goal/final state we want to achieve
        let goalCenter = self.destination.view.center
        let goalScale = self.destination.view.transform
        
        // Then actually set the views to the initial state for the animation
        self.destination.view.center = self.launchView?.center ?? CGPoint(x: 0, y: 0)
        self.destination.view.transform = self.destination.view.transform.scaledBy(x: 0.05, y: 0.05)
        
        UIView.animate(withDuration: AppStyle.Animations.Expand.duration,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: {
                        
                        // Animate from the orig state to the goal state
                        self.destination.view.transform = goalScale
                        self.destination.view.center = goalCenter

                        // We also want to hide the launching view to avoid the cognitive dissonance
                        // of the view "copying" itself to the full view instead of expanding itself.
                        self.launchView?.isHidden = true
                        
        }) { (finished) in
            
            // Clean up and actually present the expanded VC
            self.destination.view.removeFromSuperview()
            self.source.present(self.destination, animated: false, completion: nil)
        }
        
    }
    
}
