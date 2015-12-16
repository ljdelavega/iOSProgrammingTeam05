//
//  Budget.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-26.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class Budget: NSObject, NSCoding {

    /* Fields:
    Amount
    Remaining
    Title
    Date
    Description
    Time period
    Repeating flag
    Monthly
    Weekly
    Daily
    */
    
    // MARK: Properties
    // Put fields pertaining to the data model class here.
    var name: String
    var amount: NSDecimalNumber
    var remaining: NSDecimalNumber
    var desc: String
    var date: NSDate
    var repeating: Bool
    var photo: UIImage?
    
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("budgets")
    
    // MARK: Types
    
    struct PropertyKey {
        // Property keys used to encode and decode data
        static let nameKey = "name"
        static let amountKey = "amount"
        static let remainingKey = "remaining"
        static let descKey = "desc"
        static let dateKey = "date"
        static let repeatingKey = "repeating"
        static let photoKey = "photo"
    }
    
    // MARK: Initialization
    //name: String, amount: NSDecimalNumber, remaining: NSDecimalNumber, desc: String, date: NSDate, repeating: Bool
    init?(name: String, amount: NSDecimalNumber, remaining: NSDecimalNumber, desc: String, date: NSDate, repeating: Bool) {
        // Initialize stored properties.
        self.name = name
        self.amount = amount
        self.remaining = remaining
        self.desc = desc
        self.date = date
        self.repeating = repeating
        
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
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(repeating, forKey: PropertyKey.repeatingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // initialize by decoding an existing object from persistent data.
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! NSDecimalNumber
        let remaining = aDecoder.decodeObjectForKey(PropertyKey.remainingKey) as! NSDecimalNumber
        let desc = aDecoder.decodeObjectForKey(PropertyKey.descKey) as! String
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as! NSDate
        
        let repeating = aDecoder.decodeBoolForKey(PropertyKey.repeatingKey)
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        // Must call designated initializer.
        self.init(name: name, amount: amount, remaining: remaining, desc: desc, date: date, repeating: repeating)
        self.photo = photo
    }
    
}
