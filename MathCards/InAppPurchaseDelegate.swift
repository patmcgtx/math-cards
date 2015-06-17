//
//  InAppPurchaseDelegate.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/27/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation

protocol InAppPurchaseDelegate : NSObjectProtocol {

    func inAppPurchaseIsAvailable()
    func inAppPurchaseIsNotAvailable()
    
    func inAppPurchasePending()
    func inAppPurchaseSucceeded()
    func inAppPurchaseFailed(error: NSError)
    func inAppPurchaseRestored()
}
