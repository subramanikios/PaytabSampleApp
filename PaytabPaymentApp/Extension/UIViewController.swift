//
//  UIViewController.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showSimpleAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message,         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
