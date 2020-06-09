//
//  Container.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import Foundation


class Container{
    
    var global:Global?
    
    static let sharedInstance: Container = {
        let instance = Container()
        // setup code
        return instance
    }()
    
    func Initialize() {
        global = Global()
    }
}
