//
//  GoalViewController.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-27.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit
import MLVerticalProgressView

// Primary Goal Screen
class GoalViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var amountRemainingLabel: UILabel!
    @IBOutlet weak var contributeButton: UIButton!
    @IBOutlet weak var goalProgressView: VerticalProgressView!
    
    var goals = [Goal]()
    var primaryGoal: Goal?
    var progress: Float?

    override func viewDidLoad() {
        super.viewDidLoad()
        progress = 0.0
        
        //change button design
        //contributeButton.layer.borderColor = UIColor.blackColor().CGColor
        contributeButton.layer.borderWidth = 1
        contributeButton.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
        updateInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateInterface() {
        // Load any saved goals, otherwise load sample data.
        if let savedGoals = loadGoals() {
            goals = savedGoals
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
        
        // update the progress view with animation
        updateProgressView()
    }
    
    func updateProgressView() {
        progress = (primaryGoal!.contributed / primaryGoal!.amount).floatValue
        if (progress < 0.25)
        {
            goalProgressView.fillDoneColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.25)
        }
        else if (progress < 0.5)
        {
            goalProgressView.fillDoneColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.50)
        }
        else if (progress < 0.75)
        {
            goalProgressView.fillDoneColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.75)
        }
        else
        {
            goalProgressView.fillDoneColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        }
        goalProgressView.setNeedsLayout()

        
        goalProgressView.setProgress(progress!, animated: true)
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
    
    var tField: UITextField!

    @IBAction func contributePressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Contribute", message: "Enter the amount you wish to contribute:", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler(configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:handleCancel))
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            print("Done !!")
            print("Input : \(self.tField.text!)")
            let amount = self.tField.text!
            self.contributeToGoal(amount)
        }))
        self.presentViewController(alert, animated: true, completion: {
            print("completion block")
        })

        
    }
    
    // helper functions for handling input in contribution UIAlertController
    func configurationTextField(textField: UITextField!)
    {
        print("generating the TextField")
        textField.placeholder = "Contribution amount..."
        textField.keyboardType = UIKeyboardType.DecimalPad
        tField = textField
    }
    
    
    func handleCancel(alertView: UIAlertAction!)
    {
        print("Cancelled !!")
    }
    
    // contribute to the goal
    func contributeToGoal(amount: String)
    {
        let contribution = NSDecimalNumber(string: amount)
        primaryGoal?.contributed = (primaryGoal?.contributed)! + contribution
        if (primaryGoal?.contributed >= primaryGoal?.amount)
        {
            // goal reached!
            
            let alertController = UIAlertController(title: "Goal reached!", message: "Congratulations! You have reached your goal!", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
        }
        else
        {
            // Goal not reached yet. Show a motivational message.
            var message: String
            let contributed = primaryGoal?.contributed
            let amount = primaryGoal?.amount
            let remaining = amount! - contributed!
            // calculate closest motivational message.
            // round NSDecimalNumber up
            let daysLeft = (remaining / contribution).decimalNumberByRoundingAccordingToBehavior( NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundUp, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
            message = "\(daysLeft) days"
            let alertController = UIAlertController(title: "Goal progress!", message: "If you contributed this much every day, you would reach your goal in \(message)!", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        // save the goals
        saveGoals()
        // reload the view to update
        updateInterface()
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
        updateInterface()
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
