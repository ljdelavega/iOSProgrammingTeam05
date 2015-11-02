//
//  GoalViewController.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-27.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        /*
        let vc: UINavigationController = segue.destinationViewController as! UINavigationController
        let mealTableViewController = vc.topViewController as! MealTableViewController
        //let mealTableViewController = segue.destinationViewController as! MealTableViewController
        
        // Get the cell that generated this segue.
        if let selectedCell = sender as? MealCategoriesTableViewCell {
            let indexPath = tableView.indexPathForCell(selectedCell)!
            let selectedCategory = categories[indexPath.row]
            mealTableViewController.category = selectedCategory
        }
        */
    }
    
    @IBAction func unwindToPrimaryGoal(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GoalTableViewController {
            sourceViewController.saveGoals()
        }
    }

}
