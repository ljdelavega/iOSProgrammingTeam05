//
//  FirstViewController.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-19.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, UITextFieldDelegate{

    var transactions = [Transaction]()
    var total = Double(0)
    var totalIncome = Double(0)
    var totalExpense = Double(0)
    var goals = [Goal]()
    
    @IBOutlet weak var income: UILabel!
    @IBOutlet weak var expense: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        overview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //does all the overview stuff
    func overview() {
        //load transactions
        if let savedTransactions = loadTransactions() {
            transactions += savedTransactions
            calculateTotal()
            
        } else {
            loadSampleTransactions()
            calculateTotal()
        }
        
        //load goals
        if let savedGoals = loadGoals() {
            goals = savedGoals
            loadPrimaryGoal()
            
        } else {
            // Load the sample data.
        }
    }
    
    
    func loadSampleTransactions() {
        
        let photo1 = UIImage(named: "entertainment")!
        let expense1 = Transaction(name: "Entertainment", amount: 45.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false", photo: photo1, savedCat: "Shopping")!
        expense1.photo = photo1
        
        let photo2 = UIImage(named: "cash")!
        let income1 = Transaction(name: "Paycheque", amount: 480.00, desc: "Part-time job", date: NSDate(), type: "Income", repeating: "false",photo: photo2, savedCat: "Shopping")!
        income1.photo = photo2
        
        let photo3 = UIImage(named: "shopping")!
        let expense2 = Transaction(name: "Shopping", amount: 60.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false",photo: photo3, savedCat: "Total")!
        expense2.photo = photo3
        
        let photo4 = UIImage(named: "cash")!
        let income2 = Transaction(name: "Allowance", amount: 100.00, desc: "Given by parents", date: NSDate(), type: "Income", repeating: "false", photo: photo4, savedCat: "Total")!
        income2.photo = photo4
        
        let photo5 = UIImage(named: "food")!
        let expense3 = Transaction(name: "Food", amount: 99.25, desc: "Eating out at restaurants", date: NSDate(), type: "Expense", repeating: "false",photo: photo5, savedCat: "Other")!
        expense3.photo = photo5
        
        let photo6 = UIImage(named: "sports")!
        let expense4 = Transaction(name: "Sports", amount: 20.75, desc: "Sporting events", date: NSDate(), type: "Expense", repeating: "false", photo: photo6, savedCat: "Other")!
        expense4.photo = photo6
        
        
        let photo7 = UIImage(named: "gas")!
        let expense5 = Transaction(name: "Gas", amount: 30.58, desc: "Gas for car", date: NSDate(), type: "Expense", repeating: "false", photo:  photo7, savedCat: "Other")!
        expense5.photo = photo7
        
        let photo8 = UIImage(named: "groceries")!
        let expense6 = Transaction(name: "Groceries", amount: 300, desc: "Grocery shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Other")!
        expense6.photo = photo8
        
        transactions += [expense1, income1, expense2, income2, expense3, expense4, expense5, expense6]
    }

    
    
    //calculates and fills in the overview (top part with income, expense, and total)
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
    
    
    //load primary goals
    func loadPrimaryGoal() {
        var primaryGoal = goals[0]
        for goal in goals
        {
            if (goal.primary)
            {
                primaryGoal = goal
            }
        }
        // if no primary goal is found, default to the first goal in the list.
        
        nameLabel.text = primaryGoal.name
        costLabel.text = String(primaryGoal.contributed.asLocaleCurrency) + " / " + String(primaryGoal.amount.asLocaleCurrency)
        var progress = primaryGoal.contributed / primaryGoal.amount
        if (progress > 1) {
            progress = NSDecimalNumber(int: 1)
        }
        // change color of the progress bar depending on how far they are
        if (progress < 0.25)
        {
            progressView.progressTintColor = UIColor(red: 168.0/255.0, green: 241.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        }
        else if (progress < 0.5)
        {
            progressView.progressTintColor = UIColor(red: 105.0/255.0, green: 237.0/255.0, blue: 206.0/255.0, alpha: 1.0)
            
        }
        else if (progress < 0.75)
        {
            progressView.progressTintColor = UIColor(red: 105.0/255.0, green: 219.0/255.0, blue: 179.0/255.0, alpha: 1.0)
        }
        else
        {
            progressView.progressTintColor = UIColor(red: 69.0/255.0, green: 198.0/255.0, blue: 153.0/255.0, alpha: 1.0)
        }
        progressView.trackTintColor = UIColor.whiteColor()
        progressView.progress = progress.floatValue
        imageView.image = primaryGoal.photo

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

