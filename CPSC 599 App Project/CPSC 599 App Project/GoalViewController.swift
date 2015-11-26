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
    
    var goals = [Goal]()

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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadSampleGoals() {
        
        let goal1 = Goal(name: "Trip to Niagara Falls", amount: 1000, contributed: 0, desc: "Plane ticket to Ontario. Hotel Accomodations", primary: true)!
        let photo1 = UIImage(named: "defaultPhoto")!
        goal1.photo = photo1
        goals += [goal1]
        
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
