//
//  GoalViewController.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-27.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

// Primary Goal Screen
class GoalViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var amountRemainingLabel: UILabel!
    @IBOutlet weak var contributeButton: UIButton!
    
    
    var goals = [Goal]()
    var primaryGoal: Goal?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load any saved goals, otherwise load sample data.
        if let savedGoals = loadGoals() {
            goals += savedGoals
        } else {
            // Load the sample data.
            loadSampleGoals()
        }
        // get the primary goal from the list of goals.
        loadPrimaryGoal()
        
        // populate the fields with information for the primary goal
        nameLabel.text = primaryGoal?.name
        progressLabel.text = primaryGoal!.contributed.asLocaleCurrency + " / " + primaryGoal!.amount.asLocaleCurrency
        amountRemainingLabel.text = (primaryGoal!.amount - primaryGoal!.contributed).asLocaleCurrency
        /*
        cell.costLabel.text = goal.contributed.asLocaleCurrency + " / " + goal.amount.asLocaleCurrency
        var progress = goal.contributed / goal.amount
        if (progress > 1) {
            progress = NSDecimalNumber(int: 1)
        }
        cell.progressView.progress = progress.floatValue
        */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadSampleGoals() {
        
        let goal1 = Goal(name: "Trip to Niagara Falls", amount: 1000, contributed: 0, desc: "Plane ticket to Ontario. Hotel Accomodations", primary: true)!
        let photo1 = UIImage(named: "defaultPhoto")!
        goal1.photo = photo1
        
        let goal2 = Goal(name: "New MacBook", amount: 1500, contributed: 0, desc: "A new MacBook Pro from the Apple store.", primary: false)!
        let photo2 = UIImage(named: "defaultPhoto")!
        goal2.photo = photo2
        
        goals += [goal1, goal2]
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

    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    
    @IBAction func unwindToPrimaryGoal(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GoalTableViewController {
            sourceViewController.saveGoals()
        }
        self.viewDidLoad()
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
