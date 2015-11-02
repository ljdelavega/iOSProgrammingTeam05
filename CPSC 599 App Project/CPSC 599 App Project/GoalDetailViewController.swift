//
//  GoalDetailViewController.swift
//  CPSC 599 App Project
//
//  Created by Lester Dela Vega on 2015-10-30.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class GoalDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descTextField: UITextView!
    @IBOutlet weak var primaryCheck: Checkbox!
    //@IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    
    /*
    This value is either passed by `GoalTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new goal.
    */
    var goal: Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let goal = goal {
            navigationItem.title = goal.name
            nameTextField.text = goal.name
            amountTextField.text   = goal.amount.stringValue
            descTextField.text   = goal.desc
            //photoImageView.image = meal.photo
            primaryCheck.selected = goal.primary
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidGoal()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidGoal()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidGoal() {
        // Disable the Save button if not a valid goal.
        let text = nameTextField.text ?? ""
        let num = amountTextField.text ?? ""
        saveButton.enabled = !text.isEmpty && !num.isEmpty
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    /*
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        //photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    */
    
    // MARK: Navigation
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddGoalMode = presentingViewController is UINavigationController
        
        if isPresentingInAddGoalMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            
            let name = nameTextField.text ?? ""
            let amount = NSDecimalNumber(string: amountTextField.text)
            let remaining = NSDecimalNumber(string: amountTextField.text)
            let desc = descTextField.text
            let primary = primaryCheck.selected
            

            
            // Set the meal to be passed to MealListTableViewController after the unwind segue.
            goal = Goal(name: name, amount: amount, remaining: remaining, desc: desc, primary: primary)
            
        }
    }
    
    // MARK: Actions
    /*
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    */
    
}

