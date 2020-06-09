//
//  UITextField.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    
    func unwrapTextString()->String{
        self.text ?? ""
    }
    
    func isEmpty()->Bool{
        return (self.text == "") ? true : false
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.text)
    }

}
