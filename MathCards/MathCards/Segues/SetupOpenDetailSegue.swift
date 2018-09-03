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
class SetupOpenDetailSegue : UIStoryboardSegue {

    var launchPoint = CGPoint.init(x: 0.0, y: 0.0)
    
    override func perform() {
        
        // Add the destination view as a subview, temporarily
        self.source.view.addSubview(self.destination.view)
        
        // Starting point for the animation; start small at the launch point
        let goalDestCenter = self.destination.view.center
        self.destination.view.center = self.launchPoint
        self.destination.view.transform = CGAffineTransform.init(scaleX: 0.05, y: 0.05)
        
        UIView.animate(withDuration: AppStyle.Animations.Expand.duration, animations: {
            // Animate expanding out to the goal state
            self.destination.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.destination.view.center = goalDestCenter
        }) { (finished) in
            // And finally, actually present the new VC
            self.source.present(self.destination, animated: false, completion: nil)
        }
        
    }
    
}
