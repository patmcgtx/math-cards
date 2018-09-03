//
//  SetupToDetailSegue.swift
//  MathCards
//
//  Created by Patrick McGonigle on 9/2/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

/**
 TODO
 */
class ExpandToDetailSegue : UIStoryboardSegue {
    
    // TODO
    var expandFrom: UIView? = nil
    
    override func perform() {
        
        if let masterView = self.source.view,
            let detailView = self.destination.view {
            
            masterView.addSubview(detailView)
            
            // Before doing the animation, record the full/goal/final state we want to achieve
            let goalCenter = detailView.center
            let goalScale = detailView.transform
            
            // Then actually set the views to the initial state for the animation
            detailView.center = self.expandFrom?.center ?? CGPoint(x: 0, y: 0)
            detailView.transform = detailView.transform.scaledBy(x: 0.05, y: 0.05)
            
            UIView.animate(withDuration: AppStyle.Animations.Expand.duration,
                           delay: 0.0,
                           options: UIViewAnimationOptions.curveEaseOut,
                           animations: {
                            
                            // Animate from the orig state to the goal state
                            detailView.transform = goalScale
                            detailView.center = goalCenter
                            
                            // We also want to hide the launching view to avoid the cognitive dissonance
                            // of the view "copying" itself to the full view instead of expanding itself.
                            self.expandFrom?.alpha = 0.0
                            
            }) { (finished) in
                
                // Clean up and actually present the expanded VC
                detailView.removeFromSuperview()
                self.source.present(self.destination, animated: false, completion: nil)
            }
        }
    }
    
}
