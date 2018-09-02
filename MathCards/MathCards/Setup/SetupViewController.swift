//
//  SetupViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 8/24/18.
//  Copyright © 2018 Round Trip Software. All rights reserved.
//

import UIKit

/**
 The initial view controller for setting up a run of the math cards.
 */
class SetupViewController : UIViewController {
    
    private let transitionAnimator = SetupTransitionAnimator()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.transitioningDelegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
}

/*
 TODO REMOVE THIS
 
// MARK: UIViewControllerTransitioningDelegate
// Animate "exploding" into sub-controls as a VC transition animation

extension SetupViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transitionAnimator
    }
    
}

class SetupTransitionAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // TODO
    }
 
}
*/
