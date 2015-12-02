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
/*
    func loadGoalinTableView() {
        self.tableView.registerClass(GoalTableViewCell.self, forCellReuseIdentifier: "GoalTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GoalTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GoalTableViewCell
        if let label = cell.nameLabel {
            label.text = primaryGoal?.name
        }
        if let label2 = cell.costLabel {
            label2.text = String(primaryGoal?.amount)
        }
        return cell
    }*/
    
    
    
    //does all the overview stuff
    func overview() {
        //load transactions
        if let savedTransactions = loadTransactions() {
            transactions += savedTransactions
            calculateTotal()
            
        } else {
            
        }
        
        //load goals
        if let savedGoals = loadGoals() {
            goals = savedGoals
            loadPrimaryGoal()
            
        } else {
            // Load the sample data.
        }
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

