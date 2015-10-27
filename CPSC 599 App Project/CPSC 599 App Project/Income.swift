//
//  Income.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-26.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class Income: NSObject, NSCoding {
    
    /* Fields:
    Amount
    Source / Title
    Description
    Date 
    */
    // MARK: Properties
    // Put fields pertaining to the data model class here.
    var name: String
    var amount: NSDecimalNumber
    var desc: String
    var date: NSDate
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("income")
    
    // MARK: Types
    
    struct PropertyKey {
        // Property keys used to encode and decode data
        static let nameKey = "name"
        static let amountKey = "amount"
        static let remainingKey = "remaining"
        static let descKey = "desc"
        static let dateKey = "date"
        static let repeatingKey = "repeating"
    }
    
    // MARK: Initialization
    
    init?(name: String, amount: NSDecimalNumber, desc: String, date: NSDate) {
        // Initialize stored properties.
        self.name = name
        self.amount = amount
        self.desc = desc
        self.date = date
        
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
        aCoder.encodeObject(desc, forKey: PropertyKey.descKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // initialize by decoding an existing object from persistent data.
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! NSDecimalNumber
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        
        
        // Because photo is an optional property of Meal, use conditional cast.
        //let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        // Must call designated initializer.
        self.init(name: name, amount: amount, desc: desc, date: date)
    }
}
