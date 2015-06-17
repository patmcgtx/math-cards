//
//  InAppPurchaseClerk.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/27/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import Foundation
import StoreKit

class InAppPurchaseClerk: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    // MARK: Public properties
    
    weak var delegate: InAppPurchaseDelegate?
    
    
    var isReadyForPurchase: Bool {
        return self._product? != nil
    }
    
    
    var localizedProductDescription: String? {
        
        var retval: String? = nil
        
        if let product = self._product? {
            retval = product.localizedDescription
        }
        
        return retval
    }

    
    var localizedProductTitle: String? {
        
        var retval: String? = nil
        
        if let product = self._product? {
            retval = product.localizedTitle
        }
        
        return retval
    }

    
    var localizedProductPrice: String? {
        
        var retval: String? = nil
        
        if let product = self._product? {
            
            let formatter = NSNumberFormatter()
            formatter.formatterBehavior = NSNumberFormatterBehavior.Behavior10_4
            formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            formatter.locale = product.priceLocale
            
            retval = formatter.stringFromNumber(product.price)
        }
        
        return retval
    }
    
    
    // MARK: Private properties
    
    var _productId: String = "TBD"
    var _product: SKProduct?
    
    
    // MARK: Lifecycle
    
    init(productId: String!) {
        self._productId = productId
    }
    
    
    // MARK: Public functions
    
    func startPreparingProduct() {
        
        let productSet = NSMutableSet()
        productSet.addObject(self._productId)
        
        let productRequest = SKProductsRequest(productIdentifiers: productSet)
        productRequest.delegate = self
        
        // Calls productsRequest(didReceiveResponse:) when done
        productRequest.start()
    }
    
    
    func startPurchasingProduct() {
        
        if let product = self._product? {
            let payment = SKPayment(product: product)
            SKPaymentQueue.defaultQueue().addPayment(payment)
        }
        
    }
    
    
    // MARK: Delegates / observers
    
    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        
        for aProductAnyObj in response.products {
            if let aProduct = aProductAnyObj as? SKProduct {
                if aProduct.productIdentifier == self._productId {
                    self._product = aProduct
                }
            }
        }
        
        if (self._product != nil) {
            SKPaymentQueue.defaultQueue().addTransactionObserver(self)
            self.delegate?.inAppPurchaseIsAvailable()
        }
        else {
            self.delegate?.inAppPurchaseIsNotAvailable()
        }
        
    }
    
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        
        for txn in transactions {
            
            if let paymentTxn = txn as? SKPaymentTransaction {
                
                switch paymentTxn.transactionState {
                    
                case .Purchased:
                    self.delegate?.inAppPurchaseSucceeded()
                    
                case .Failed:
                    self.delegate?.inAppPurchaseFailed(paymentTxn.error)
                    
                case .Purchasing, .Deferred:
                    self.delegate?.inAppPurchasePending()
                    
                case .Restored:
                    self.delegate?.inAppPurchaseRestored()

                default: ()
                }
            }
        }
    }
    
    
}
