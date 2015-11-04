//
//  TransactionTableViewController.swift
//  CPSC 599 App Project
//
//  Created by Brandon Yip on 2015-11-02.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class TransactionTableViewController: UITableViewController {

    var transactions = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        loadSampleTransactions()
    }
    
    func loadSampleTransactions() {
        
        let expense1 = Transaction(name: "Gift", amount: 45.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: false)!
        
        
        let income1 = Transaction(name: "Salary", amount: 250.00, desc: "Job", date: NSDate(), type: "Income", repeating: false)!
        
        transactions += [expense1, income1]
        
        
        
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
        return transactions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TransactionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TransactionTableViewCell
        let transaction = transactions[indexPath.row]
        
        //converts NSDate into NSString
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let datePrefix: String = formatter.stringFromDate(transaction.date)
        
        
        //fills the cell with the information
        cell.titleLabel.text = transaction.name
        cell.dateLabel.text = datePrefix
        cell.priceLabel.text = transaction.amount.asLocaleCurrency
        
        if transaction.type == "Expense" {
            cell.priceLabel.textColor = UIColor.redColor()
        } else if transaction.type == "Income"{
            cell.priceLabel.textColor = UIColor.greenColor()
        }
        // Configure the cell...
        
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
            transactions.removeAtIndex(indexPath.row)
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

    
    // MARK: - Navigation

    @IBAction func unwindToTransactionList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.sourceViewController as? TransactionViewController, transaction = sourceViewController.transaction {
            
            //edits and replaces old transaction with newly edited transaction
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                transactions[selectedIndexPath.row] = transaction
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
                
            //add a new transaction
            else {
                let newIndexPath = NSIndexPath(forRow: transactions.count, inSection: 0)
                //append to the list of transactions
                transactions.append(transaction)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
           let transactionDetailViewController = segue.destinationViewController as! TransactionViewController
            if let selectedTransactionCell = sender as? TransactionTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedTransactionCell)!
                let selectedTransaction = transactions[indexPath.row]
                transactionDetailViewController.transaction = selectedTransaction
            }
        }
        else if segue.identifier == "AddItem" {
            
        }
        else {
            print("Adding new Transaction")
        }
    }

}
