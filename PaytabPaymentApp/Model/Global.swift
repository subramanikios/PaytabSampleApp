//
//  Global.swift
//  PaytabPaymentApp
//
//  Created by Mathew on 6/7/20.
//  Copyright © 2020 Subramani. All rights reserved.
//

import Foundation


class Global{
    
    let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
    var merchant:MerchantInfo?
    
    init() {
        self.getMerchantInfo()
    }
    
    func getMerchantInfo(){
        merchant = MerchantInfo()
        merchant?.secretKey = self.readPropertyList(plistName: "MerchantInfo")["secretKey"] as? String
        merchant?.email = self.readPropertyList(plistName: "MerchantInfo")["email"] as? String
    }
    
    func readPropertyList(plistName:String)->[String: Any] {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:] //Our data
        let plistPath: String? = Bundle.main.path(forResource: plistName, ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            return plistData
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
        return [:]
    }
}
