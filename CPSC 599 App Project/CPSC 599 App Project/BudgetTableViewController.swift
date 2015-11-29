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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadSampleBudgets()
    }
    
    func loadSampleBudgets() {
        
        //name: String, amount: NSDecimalNumber, remaining: NSDecimalNumber, desc: String, date: NSDate, repeating: Bool
        let budget1 = Budget(name: "Total", amount: 1000.00, remaining: 750.00, desc: "Total Budget", date: NSDate(), repeating: false)!
        
        let budget2 = Budget(name: "Shopping", amount: 500.00, remaining: 250.00, desc: "Shopping Budget", date: NSDate(), repeating: false)!
        
        budgets += [budget1, budget2]
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

    @IBAction func unwindToBudgetList(sender: UIStoryboardSegue) {
        
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
     
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
