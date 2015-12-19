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
	
	override func viewWillAppear(animated: Bool) {
		overview()
	}
    
    
    //does all the overview stuff
    func overview() {
		// reset the total income and expenses
		totalExpense = 0.0
		totalIncome = 0.0
		total = 0.0
        //load transactions
        if let savedTransactions = loadTransactions() {
            transactions = savedTransactions
            calculateTotal()
            
        } else {
            loadSampleTransactions()
            calculateTotal()
        }
        
		// Load any saved goals, otherwise load sample data.
		if let savedGoals = loadGoals() {
			goals = savedGoals
		} else {
			// Load the sample data.
			loadSampleGoals()
		}
		// load the primary goal.
		loadPrimaryGoal()
	}
	
	func loadSampleGoals() {
		
		let goal1 = Goal(name: "Trip to Niagara Falls", amount: 1000, contributed: 0, desc: "Plane ticket to Ontario. Hotel Accomodations", primary: false)!
		let photo1 = UIImage(named: "defaultPhoto")!
		goal1.photo = photo1
		
		let goal2 = Goal(name: "New MacBook", amount: 1500, contributed: 0, desc: "A new MacBook Pro from the Apple store.", primary: false)!
		let photo2 = UIImage(named: "MacBook")!
		goal2.photo = photo2
		
		let goal3 = Goal(name: "Student Loans", amount: 20000, contributed: 0, desc: "Paying off student loans for University of Calgary tuition.", primary: true)!
		let photo3 = UIImage(named: "UofC")!
		goal3.photo = photo3
		
		goals += [goal3, goal2, goal1]
		
	}
	
	
    func loadSampleTransactions() {
		let photo1 = UIImage(named: "entertainment")!
		let expense1 = Transaction(name: "One Direction concert", amount: 405.25, desc: "Directioner for Lyfe", date: NSDate(), type: "Expense", repeating: "false", photo: photo1, savedCat: "Other")!
		expense1.photo = photo1
		
		let photo2 = UIImage(named: "cash")!
		let income1 = Transaction(name: "Got Paid!", amount: 2700.00, desc: "Full-time job", date: NSDate(), type: "Income", repeating: "false",photo: photo2, savedCat: "Other")!
		income1.photo = photo2
		
		let photo3 = UIImage(named: "shopping")!
		let expense2 = Transaction(name: "New Jeans!", amount: 60.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false",photo: photo3, savedCat: "Shopping")!
		expense2.photo = photo3
		
		let photo4 = UIImage(named: "cash")!
		let income2 = Transaction(name: "Allowance", amount: 100.00, desc: "Given by parents", date: NSDate(), type: "Income", repeating: "false", photo: photo4, savedCat: "Other")!
		income2.photo = photo4
		
		let photo5 = UIImage(named: "food")!
		let expense3 = Transaction(name: "Bought Veggies", amount: 99.25, desc: "Eating out at restaurants", date: NSDate(), type: "Expense", repeating: "false",photo: photo5, savedCat: "Food")!
		expense3.photo = photo5
		
		let photo6 = UIImage(named: "sports")!
		let expense4 = Transaction(name: "Bought a Basketball", amount: 20.75, desc: "Sporting events", date: NSDate(), type: "Expense", repeating: "false", photo: photo6, savedCat: "Shopping")!
		expense4.photo = photo6
		
		let photo7 = UIImage(named: "gas")!
		let expense5 = Transaction(name: "Bought gas", amount: 50.58, desc: "Gas for car", date: NSDate(), type: "Expense", repeating: "false", photo:  photo7, savedCat: "Utilities")!
		expense5.photo = photo7
		
		let photo8 = UIImage(named: "cash")!
		let expense6 = Transaction(name: "Paid Tuition", amount: 500.00, desc: "Tuition", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Education")!
		expense6.photo = photo8
		
		let photo9 = UIImage(named: "shopping")!
		let expense7 = Transaction(name: "Bought a TV", amount: 609.25, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
		expense7.photo = photo9
		
		let photo10 = UIImage(named: "shopping")!
		let expense8 = Transaction(name: "Bought a sweater", amount: 59.99, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
		expense8.photo = photo10
		
		let photo11 = UIImage(named: "shopping")!
		let expense9 = Transaction(name: "Bought shoes", amount: 202.09, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
		expense9.photo = photo11
		
		let photo12 = UIImage(named: "shopping")!
		let expense10 = Transaction(name: "Bought OD T-Shirt", amount: 80.00, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
		expense10.photo = photo12
		
		transactions += [income1, income2, expense1, expense2, expense3, expense4, expense5, expense6, expense7, expense8, expense9, expense10]
    }

	
	
    //calculates and fills in the overview (top part with income, expense, and total)
    func calculateTotal() {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
		// reset the total income and expenses
		totalExpense = 0.0
		totalIncome = 0.0
		total = 0.0

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

