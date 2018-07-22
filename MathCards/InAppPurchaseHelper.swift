//
//  InAppPurchaseHelper.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/22/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation
import StoreKit

let bundleIdFreeVersion = "com.roundtripsoftware.MathCardsFree"
let iapProductIdAllMath = "com.roundtripsoftware.MathCardsFree.AllMath"
let iapAllProductIdentifiers = [iapProductIdAllMath]

class InAppPurchaseHelper : NSObject, SKProductsRequestDelegate {

    // MARK: Private properties

    private var finishedInitializing: Bool = false
    private var productAllMathOps: SKProduct?


    // MARK: Public properties
    
    var isReady: Bool {
        return self.finishedInitializing
    }
    
    var areAllMathOperationsPurchased: Bool {
        let retval = !self.isFreeVersionOfApp
            return retval
    }
    
    var areAllMathEndingsPurchased: Bool {
        let retval = !self.isFreeVersionOfApp
            return retval
    }
    
    
    // MARK: Lifecycle
    
    override init() {
        
        super.init()
        
        // Look up avalable IAP products from Apple
        let prodReq = SKProductsRequest(productIdentifiers: NSSet(array: iapAllProductIdentifiers) as! Set<String>)
        prodReq.start()
    }
    
    
    // MARK: Payments
    
    func startPayingForAllMathOps() {
        let payment = SKPayment(product: (self.productAllMathOps!))
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    
    // MARK: Delegate
    
    func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        
        // Apple responds with the available IAP products
        for aProduct in response.products {
            switch aProduct.productIdentifier {
            // Save off expected products
            case iapProductIdAllMath: self.productAllMathOps = aProduct
            default: ()
            }
        }
        
        self.finishedInitializing = true
    }
    
    
    // MARK: Internal helpers
    
    private var isFreeVersionOfApp: Bool {
        
        var retval = false
            
            if let bundleId:String = NSBundle.mainBundle().bundleIdentifier {
                if bundleId == bundleIdFreeVersion {
                    retval = true
                }
            }
            
            return retval
    }
    
    
    // MARK: Singleton stuff
    // http://code.martinrue.com/posts/the-singleton-pattern-in-swift

    class var sharedInstance: InAppPurchaseHelper {
        
    struct Static {
        static var instance: InAppPurchaseHelper?
        static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = InAppPurchaseHelper()
        }
        
        return Static.instance!
    }
    
}