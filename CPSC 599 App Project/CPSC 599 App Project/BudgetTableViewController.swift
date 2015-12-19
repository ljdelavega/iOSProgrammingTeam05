//
//  BudgetTableViewController.swift
//  CPSC 599 App Project
//
//  Created by Home-AX50 on 2015-11-02.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class BudgetTableViewController: UITableViewController {

    var budgets = [Budget]()
    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let savedBudgets = loadBudgets()
        {
            budgets += savedBudgets
        } else {
            loadSampleBudgets()
            saveBudgets()
        }
        
        tableView.reloadData()
    }
    
    func loadSampleBudgets()
    {
        let budget1 = Budget(name: "Total", amount: 2800.00, remaining: 2087.41, desc: "Total Budget", date: NSDate())!
        let photo1 = UIImage(named: "dollarsign")!
        budget1.photo = photo1
        
        let budget3 = Budget(name: "Education", amount: 500.00, remaining:500.00, desc: "Education Budget", date: NSDate())!
        let photo3 = UIImage(named: "education")!
        budget3.photo = photo3
        
        let budget4 = Budget(name: "Food", amount: 100.00, remaining: 99.25, desc: "Food Budget", date: NSDate())!
        let photo4 = UIImage(named: "NEWfoodICON")!
        budget4.photo = photo4
        
        let budget5 = Budget(name: "Utilities", amount: 100.00, remaining: 50.58, desc: "Utilities Budget", date: NSDate())!
        let photo5 = UIImage(named: "NEWutilitiesICON")!
        budget5.photo = photo5
        
        let budget6 = Budget(name: "Shopping", amount: 1500.00, remaining: 1032.33, desc: "Shopping Budget", date: NSDate())!
        let photo6 = UIImage(named: "shoppingcart")!
        budget6.photo = photo6
        
        let budget7 = Budget(name: "Other", amount: 600.00, remaining: 405.25, desc: "Other Budget", date: NSDate())!
        let photo7 = UIImage(named: "NEWotherICON")!
        budget7.photo = photo7
        
        budgets += [budget1, budget3, budget4, budget5, budget6, budget7]
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
        return budgets.count
    }

    @IBAction func unwindToBudgetList(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.sourceViewController as? BudgTranTableViewController, budget = sourceViewController.budget {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing goal.
                budgets[selectedIndexPath.row] = budget
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new goal.
                let newIndexPath = NSIndexPath(forRow: budgets.count, inSection: 0)
                budgets.append(budget)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
		saveBudgets()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "BudgetTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetTableViewCell
        let budget = budgets[indexPath.row]
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        cell.budgetNameLbl.text = budget.name
        cell.budgetAmtLbl.text = budget.remaining.asLocaleCurrency + "/" + budget.amount.asLocaleCurrency
        
        var progress = budget.remaining / budget.amount
        if (progress > 1) {
            progress = NSDecimalNumber(int: 1)
        }
        cell.budgetProgBar.progress = progress.floatValue
     
        cell.budgetPic.image = budget.photo
        
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

    //MARK: - NSCoding
    func saveBudgets() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(budgets, toFile: Budget.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save transactions...")
        }
    }
    
    func loadBudgets() -> [Budget]?
    {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Budget.ArchiveURL.path!) as? [Budget]
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowDetail"
        {
            let budgetDetailViewController = segue.destinationViewController as! BudgTranTableViewController
            
            //Get cell that generated this segue.
            if let selectedBudgetCell = sender as? BudgetTableViewCell
            {
                let indexPath = tableView.indexPathForCell(selectedBudgetCell)!
                let selectedBudget = budgets[indexPath.row]
                budgetDetailViewController.budget = selectedBudget
            }
        }
        saveBudgets()
        self.tableView.reloadData()        
    }
    

}
