//
//  Goal.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-26.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class Goal: NSObject, NSCoding {

    
    /* Fields:
    Amount
    Remaining
    Title
    Date
    Description
    Time Period
    */
    
    // MARK: Properties
    // Put fields pertaining to the data model class here.
    var name: String
    var amount: NSDecimalNumber
    var remaining: NSDecimalNumber
    var desc: String
    var primary: Bool
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("goals")
    
    // MARK: Types
    
    struct PropertyKey {
        // Property keys used to encode and decode data
        static let nameKey = "name"
        static let amountKey = "amount"
        static let remainingKey = "remaining"
        static let descKey = "desc"
        static let primaryKey = "primary"
    }
    
    // MARK: Initialization
    
    init?(name: String, amount: NSDecimalNumber, remaining: NSDecimalNumber, desc: String, primary: Bool) {
        // Initialize stored properties.
        self.name = name
        self.amount = amount
        self.remaining = remaining
        self.desc = desc
        self.primary = primary
        
        super.init()
        
        // Initialization should fail if there is no name or if the amount is negative.
        if (name.isEmpty || amount.compare(NSDecimalNumber(int: 0)) == NSComparisonResult.OrderedAscending) {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        // encode the fields that we want to save and persist
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
        aCoder.encodeObject(remaining, forKey: PropertyKey.remainingKey)
        aCoder.encodeObject(desc, forKey: PropertyKey.descKey)
        aCoder.encodeBool(primary, forKey: PropertyKey.primaryKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // initialize by decoding an existing object from persistent data.
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! NSDecimalNumber
        let remaining = aDecoder.decodeObjectForKey(PropertyKey.remainingKey) as! NSDecimalNumber
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as! String
        
        let primary = aDecoder.decodeBoolForKey(PropertyKey.primaryKey)
        
        // Because photo is an optional property of Meal, use conditional cast.
        //let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        // Must call designated initializer.
        self.init(name: name, amount: amount, remaining: remaining, desc: desc, primary: primary)
    }
}
