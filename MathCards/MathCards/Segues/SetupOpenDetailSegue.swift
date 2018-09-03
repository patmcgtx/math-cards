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

    override func perform() {
        
        // Assign the source and destination views to local variables.
        let firstVCView = self.source.view
        let secondVCView = self.destination.view
        
        // Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width;
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Specify the initial position of the destination view.
        secondVCView?.frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: screenHeight);
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.4, animations: { () -> Void in

            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: 0.0, dy: -screenHeight))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: 0.0, dy: -screenHeight))!
            
        }) { (Finished) -> Void in
            self.source.present(self.destination, animated: false, completion: {
                // nil
            })
        }
        
    }
    
}
