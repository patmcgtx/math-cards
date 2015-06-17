//
//  LaunchImageViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/19/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class LaunchImageViewController : UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        // In info.plist, also have to set UIViewControllerBasedStatusBarAppearance to NO
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation:UIStatusBarAnimation.None)
    }
    
}
