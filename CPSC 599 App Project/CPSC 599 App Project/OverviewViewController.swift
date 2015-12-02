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
    var goals = [Goal]()
    var primaryGoal: Goal?
    
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var expense: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let savedGoals = loadGoals() {
            goals = savedGoals
        } else {
            // Load the sample data.
        }
        
        overview()
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
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")

        for var i = 0; i < transactions.count; i++ {
            let transaction = transactions[i]
            if(transaction.type == "Expense"){
                totalExpense += Double(transaction.amount)
            } else {
                totalIncome += Double(transaction.amount)
            }
        }
        income.text = formatter.stringFromNumber(NSNumber(double: totalIncome))
        expense.text = formatter.stringFromNumber(NSNumber(double: totalExpense))
        total = totalIncome - totalExpense
        totalLabel.text = formatter.stringFromNumber(NSNumber(double: total))
    }
    
    
    
    func loadPrimaryGoal() {
        for goal in goals
        {
            if (goal.primary)
            {
                primaryGoal = goal
            }
        }
        // if no primary goal is found, default to the first goal in the list.
        if (primaryGoal == nil)
        {
            primaryGoal = goals[0]
        }
    }

    
    
    func loadTransactions() -> [Transaction]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Transaction.ArchiveURL.path!) as? [Transaction]
    }
    
    func loadGoals() -> [Goal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Goal.ArchiveURL.path!) as? [Goal]
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

