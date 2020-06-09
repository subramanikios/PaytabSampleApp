//
//  CheckoutViewController.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import UIKit
import PayCardsRecognizer

class CheckoutViewController: UIViewController {

    var viewModel:CheckoutViewModel?
    var payCardsRecognizer: PayCardsRecognizer?
    
    //Property
    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var mobileField:UITextField!
    @IBOutlet weak var amountField:UITextField!

    //LineOut
    @IBOutlet weak var emailLineout:UIView!
    @IBOutlet weak var mobileLineout:UIView!
    @IBOutlet weak var amountLineout:UIView!

    @IBOutlet weak var submitButton:UIButton!
    @IBOutlet weak var containerView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InitializeView()
        // Do any additional setup after loading the view.
    }
    
    func InitializeView(){
        viewModel = CheckoutViewModel()
        viewModel?.delegate = self
        InitializeStyle()
    }
    
    func InitializeStyle(){
        containerView.updateShaddow(radius: 10.0, shadowColor: UIColor.lightGray)
    }
    
    //Actions
    @IBAction func payAcion(_ sender:UIButton){
        //Initialize Pay
        let userModel = UserModel.init(_mobile: mobileField.unwrapTextString(), _mail: emailField.unwrapTextString(), _amount: Float(amountField.unwrapTextString()) ?? 0.0)
  
        if validateField(){
            viewModel?.InitializePayment(_parentView: self, userData: userModel)
        }
    }
    
    @IBAction func paybyCardScan(_ sender:UIButton){
        //Initialize recognizer
        payCardsRecognizer = PayCardsRecognizer(delegate: self, resultMode: .async, container: self.view, frameColor: .green)
        payCardsRecognizer?.delegate = self
        payCardsRecognizer?.startCamera()
    }
    
    //validate datas
    func validateField()->Bool{
        //set default color
        emailLineout.updateasLineoutNormal()
        mobileLineout.updateasLineoutNormal()
        amountLineout.updateasLineoutNormal()
        
        //validate objects
        if (emailField.isEmpty() || !emailField.isValidEmail()){
            emailLineout.updateasLinoutError()
        }
        if (mobileField.isEmpty()){
            mobileLineout.updateasLinoutError()
        }
        if (amountField.isEmpty()){
            amountLineout.updateasLinoutError()
        }
        return (!emailLineout.isLinouthasError() && !mobileLineout.isLinouthasError() && !amountLineout.isLinouthasError())
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//Payment response delegate
extension CheckoutViewController:CheckoutViewDelegate{
    
    //event for back pressed
    func backButtonEventReceived(){
    }
    
    //event for payment page view present started
    func paymentPrepareStarted(){
    }
    
    //event for payment page view present finished
    func paymentPrepareFinished(){
    }
    
    func transactionFailed(reason: String){
        self.showSimpleAlert(title: "Error", message: reason)
    }
    
    func transactionSuccess(transactionId: Int32) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController
        vc.transactionId = transactionId
         navigationController?.pushViewController(vc, animated: true)
    }
}


//Card scan response delegate
extension CheckoutViewController:PayCardsRecognizerPlatformDelegate{
    
    // PayCardsRecognizerPlatformDelegate
    func payCardsRecognizer(_ payCardsRecognizer: PayCardsRecognizer, didRecognize result: PayCardsRecognizerResult) {
        //hide camera
        payCardsRecognizer.stopCamera()
        print("recognizedNumber : \(String(describing: result.recognizedNumber))") // Card number
        print("recognizedHolderName : \(String(describing: result.recognizedHolderName))") // Card holder
        print("recognizedExpireDateMonth : \(String(describing: result.recognizedExpireDateMonth))") // Expire month
        print("recognizedExpireDateYear : \(String(describing: result.recognizedExpireDateYear))") // Expire year
    }
}


