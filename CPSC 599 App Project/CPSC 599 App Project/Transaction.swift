//
//  Transaction.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-26.
//  Coded by Brandon Yip
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class Transaction: NSObject, NSCoding {
    
    /* Fields:
    Amount
    Title
    Date
    Description
    Payee
    Repeating flag
    Monthly
    Weekly
    Daily
    */
    
    // MARK: Properties
    // Put fields pertaining to the data model class here.
    var name: String
    var amount: NSDecimalNumber
    var desc: String
    var date: NSDate
    var type: String
    var repeating: String
    var photo: UIImage?
    var cat: String
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("transactions")
    
    // MARK: Types
    
    struct PropertyKey {
        // Property keys used to encode and decode data
        static let nameKey = "name"
        static let amountKey = "amount"
        static let descKey = "desc"
        static let dateKey = "date"
        static let typeKey = "type"
        static let repeatingKey = "repeating"
        static let photoKey = "photo"
        static let catKey = "cat"
    }
    
    // MARK: Initialization
    
    init?(name: String, amount: NSDecimalNumber, desc: String, date: NSDate, type: String, repeating: String, cat: String) {
        // Initialize stored properties.
        self.name = name
        self.amount = amount
        self.desc = desc
        self.date = date
        self.type = type
        self.repeating = repeating
        self.cat = cat
        
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
        aCoder.encodeObject(type, forKey: PropertyKey.typeKey)
        aCoder.encodeObject(repeating, forKey: PropertyKey.repeatingKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(cat, forKey: PropertyKey.catKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // initialize by decoding an existing object from persistent data.
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! NSDecimalNumber
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        
        let type = aDecoder.decodeObjectForKey(PropertyKey.typeKey) as! String
        
        let repeating = aDecoder.decodeObjectForKey(PropertyKey.repeatingKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let cat = aDecoder.decodeObjectForKey(PropertyKey.catKey) as! String
        // Must call designated initializer.
        self.init(name: name, amount: amount, desc: desc, date: date, type: type, repeating: repeating, cat: cat)
        self.photo = photo
        
        
    }
}
