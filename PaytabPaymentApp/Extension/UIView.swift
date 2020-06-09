//
//  UIView.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func updateShaddow(radius:CGFloat, shadowColor:UIColor){
        
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
    }
 
    func updateasLinoutError(){
        self.backgroundColor = .red
    }
    
    func updateasLineoutNormal(){
        self.backgroundColor = .lightGray
    }
    
    func isLinouthasError()->Bool{
        return self.backgroundColor == .red ? true:false
    }
    
}


