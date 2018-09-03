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
        
        self.source.view.addSubview(self.destination.view)
        
        let goalCenter = self.destination.view.center
        let goalScale = self.destination.view.transform.scaledBy(x: 1.0, y: 1.0)
        
        self.destination.view.center = self.launchPoint
        self.destination.view.transform = self.destination.view.transform.scaledBy(x: 0.05, y: 0.05)
        
        UIView.animate(withDuration: AppStyle.Animations.Expand.duration, animations: {
            
            self.destination.view.transform = goalScale
            self.destination.view.center = goalCenter
            
        }) { (finished) in
            
            self.destination.view.removeFromSuperview()
            self.source.present(self.destination, animated: false, completion: nil)
            
        }
        
    }
    
}
