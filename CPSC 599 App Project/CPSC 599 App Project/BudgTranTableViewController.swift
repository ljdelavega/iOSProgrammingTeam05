//
//  BudgTranTableViewController.swift
//  Zeal
//
//  Created by Home-AX50 on 2015-11-30.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class BudgTranTableViewController: UITableViewController {

    var budgTrans = [Transaction]()
    var budget: Budget?
    var expenses = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       
        if let savedTransactions = loadTransactions()
        {
            budgTrans += savedTransactions
        } else {
            //loadSampleBudgets()
            loadSampleBudgTrans()
            //saveTransactions()
        }
        //loadSampleBudgTrans()
        
        navigationItem.title = budget?.name
        
        if (budget?.name)! == "Total"
        {
            //don't filter just return everything
        }
        else
        {
            // Filter the results by category
            let filteredTrans = budgTrans.filter() {
                if let category = ($0 as Transaction).category as String! {
                    return category.containsString((budget?.name)!)
                }
                else
                {
                    return false
                }
            }
            budgTrans = filteredTrans
        }
        
        checkExpenses()
    }
    
    //income-expenses
    func checkExpenses() {
        for var i = 0; i < budgTrans.count; i++
        {
           
            if(budgTrans[i].type == "Expense")
            {
                expenses += Int(budgTrans[i].amount)
            }
        }
        
        budget?.remaining = NSDecimalNumber(string: String(expenses))
    }
    func loadSampleBudgTrans() {
        
        //name: String, amount: NSDecimalNumber, remaining: NSDecimalNumber, desc: String, date: NSDate, repeating: Bool
        let photo1 = UIImage(named: "shoppingcart")!
        let expense1 = Transaction(name: "Entertainment", amount: 45.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false", photo: photo1, savedCat: "Other")!
        expense1.photo = photo1
        
        let photo2 = UIImage(named: "shoppingcart")!
        let expense2 = Transaction(name: "Shopping", amount: 60.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false", photo: photo2, savedCat: "Shopping")!
        expense2.photo = photo2
        
        let photo3 = UIImage(named: "shoppingcart")!
        let expense3 = Transaction(name: "Groceries", amount: 300, desc: "Grocery shopping", date: NSDate(), type: "Expense", repeating: "false", photo: photo3, savedCat: "Shopping")!
        expense3.photo = photo3
        
        budgTrans += [expense1, expense2, expense3]

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return budgTrans.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cellIdentifier = "BudgTranTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgTranTableViewCell
        let budgTran = budgTrans[indexPath.row]
        
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        //converts NSDate into NSString
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let datePrefix: String = formatter.stringFromDate(budgTran.date)
        // Configure the cell...
        
        cell.budgTransNameLbl.text = budgTran.name
        cell.budgTransDateLbl.text = datePrefix
        cell.budgTransPriceLbl.text = budgTran.amount.asLocaleCurrency
        
        if budgTran.type == "Expense" {
            //cell.priceLabel.textColor = UIColor(red: 223.0/255.0, green: 71.0/255.0, blue: 86.0/255.0, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 254.0/255.0, green: 218.0/255.0, blue: 221.0/255.0, alpha: 1.0)
            
        } else if budgTran.type == "Income"{
            cell.backgroundColor = UIColor(red: 232.0/255.0, green: 253.0/255.0, blue: 245.0/255.0, alpha: 1.0)
            //cell.priceLabel.textColor = UIColor(red: 58.0/255.0, green: 168.0/255.0, blue: 129.0/255.0, alpha: 1.0)
        }
        
        cell.budgTransPic.image = budgTran.photo
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    func loadTransactions() -> [Transaction]?
    {
        
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
