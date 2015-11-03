//
//  GoalTableViewController.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-30.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class GoalTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        //navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved goals, otherwise load sample data.
        if let savedGoals = loadGoals() {
            goals += savedGoals
        } else {
            // Load the sample data.
            loadSampleGoals()
        }
    }
    
    func loadSampleGoals() {

        let goal1 = Goal(name: "New Computer", amount: 1000, contributed: 0, desc: "A new computer. Separate parts should total about $1000", primary: true)!
        let photo1 = UIImage(named: "defaultImage")!
        goal1.photo = photo1
        goals += [goal1]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    @IBAction func back(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddGoalMode = presentingViewController is UINavigationController
        
        if isPresentingInAddGoalMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let goalDetailViewController = segue.destinationViewController as! GoalDetailViewController
            
            // Get the cell that generated this segue.
            if let selectedGoalCell = sender as? GoalTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedGoalCell)!
                let selectedGoal = goals[indexPath.row]
                goalDetailViewController.goal = selectedGoal
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new goal.")
        }
    }
    
    
    @IBAction func unwindToGoalList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GoalDetailViewController, goal = sourceViewController.goal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing goal.
                goals[selectedIndexPath.row] = goal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            } else {
                // Add a new goal.
                let newIndexPath = NSIndexPath(forRow: goals.count, inSection: 0)
                goals.append(goal)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            // Save the goals.
            saveGoals()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "GoalTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GoalTableViewCell
        
        // Fetches the appropriate goal for the data source layout.
        let goal = goals[indexPath.row]
        
        cell.nameLabel.text = goal.name
        cell.costLabel.text = goal.amount.asLocaleCurrency
        var progress = goal.contributed / goal.amount
        if (progress > 1) {
            progress = NSDecimalNumber(int: 1)
        }
        cell.progressView.progress = progress.floatValue
        cell.photoImageView.image = goal.photo
        
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
            goals.removeAtIndex(indexPath.row)
            saveGoals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // MARK: NSCoding
    
    func saveGoals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(goals, toFile: Goal.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save goals...")
        }
    }
    
    func loadGoals() -> [Goal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Goal.ArchiveURL.path!) as? [Goal]
    }


}
