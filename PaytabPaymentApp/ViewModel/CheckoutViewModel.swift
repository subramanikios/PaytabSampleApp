//
//  CheckoutViewModel.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import Foundation
import UIKit

protocol CheckoutViewDelegate:class {
    
    func backButtonEventReceived()
    func paymentPrepareStarted()
    func paymentPrepareFinished()
    func transactionFailed(reason: String)
    func transactionSuccess(transactionId:Int32)
}


class CheckoutViewModel : NSObject{
    
    var initialSetupViewController: PTFWInitialSetupViewController!
    var delegate:CheckoutViewDelegate?
    
    func InitializePayment(_parentView:CheckoutViewController, userData:UserModel){
        
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: Container.sharedInstance.global?.bundle,
            andWithViewFrame: _parentView.view.frame,
            andWithAmount: userData.amount ?? 0.0,
            andWithCustomerTitle: "PayTab App",
            andWithCurrencyCode: "USD",
            andWithTaxAmount: 0.0,
            andWithSDKLanguage: "en",
            andWithShippingAddress: "Manama",
            andWithShippingCity: "Manama",
            andWithShippingCountry: "BHR",
            andWithShippingState: "Manama",
            andWithShippingZIPCode: "123456",
            andWithBillingAddress: "Manama",
            andWithBillingCity: "Manama",
            andWithBillingCountry: "BHR",
            andWithBillingState: "Manama",
            andWithBillingZIPCode: "12345",
            andWithOrderID: "12345",
            andWithPhoneNumber: userData.mobile ?? "",
            andWithCustomerEmail: userData.mail ?? "",
            andIsTokenization:true,
            andIsPreAuth: false,
            andWithMerchantEmail: Container.sharedInstance.global?.merchant?.email ?? "",
            andWithMerchantSecretKey: Container.sharedInstance.global?.merchant?.secretKey ?? "",
            andWithAssigneeCode: "SDK",
            andWithThemeColor:UIColor.red,
            andIsThemeColorLight: false)
        
        self.initialSetupViewController.didReceiveBackButtonCallback = {
            self.delegate?.backButtonEventReceived()
        }
        
        self.initialSetupViewController.didStartPreparePaymentPage = {
            self.delegate?.paymentPrepareStarted()
            // Start Prepare Payment Page
            // Show loading indicator
        }
        self.initialSetupViewController.didFinishPreparePaymentPage = {
            self.delegate?.paymentPrepareFinished()
            // Finish Prepare Payment Page
            // Stop loading indicator
        }
        
        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            print("Response Code: \(responseCode)")
            print("Response Result: \(result)")

            print("transactionID: \(transactionID)")
            print("transactionState: \(transactionState)")

            // In Case you are using tokenization
            print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
            print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
            print("TOkenization Token: \(token)");
            if (responseCode == 100){
                self.delegate?.transactionSuccess(transactionId: transactionID)
            }else{
                self.delegate?.transactionFailed(reason: result)
            }
        }
        _parentView.view.addSubview(initialSetupViewController.view)
        _parentView.addChild(initialSetupViewController)
        initialSetupViewController.didMove(toParent: _parentView)
    }
}
