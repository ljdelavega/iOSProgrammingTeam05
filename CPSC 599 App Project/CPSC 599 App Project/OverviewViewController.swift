//
//  FirstViewController.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-19.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    var transactions = [Transaction]()
    var total = Double(0)
    var totalIncome = Double(0)
    var totalExpense = Double(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func overview() {
        if let savedTransactions = loadTransactions() {
            transactions += savedTransactions
            calculateTotal()
            
        } else {
            
        }
    }
    
    func calculateTotal() {
        for var i = 0; i < transactions.count; i++ {
            let transaction = transactions[i]
            if(transaction.type == "Expense"){
                totalExpense += Double(transaction.amount)
            } else {
                totalIncome += Double(transaction.amount)
            }
        }
    }
    
    func loadTransactions() -> [Transaction]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Transaction.ArchiveURL.path!) as? [Transaction]
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}

