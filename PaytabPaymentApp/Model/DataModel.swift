//
//  DataModel.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import Foundation

class UserModel{
    var mobile:String?
    var mail:String?
    var amount:Float?

    init(_mobile:String, _mail:String, _amount:Float) {
        mobile = _mobile
        mail = _mail
        amount = _amount
    }
}

class MerchantInfo{
    var secretKey:String?
    var email:String?
}
