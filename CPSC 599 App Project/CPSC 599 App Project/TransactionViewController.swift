//
//  TransactionViewController.swift
//  CPSC 599 App Project
//
//  Created by Brandon Yip on 2015-11-02.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self;
        amountTextField.delegate = self;
        dateTextField.delegate = self;
        descriptionTextField.delegate = self;
        // Do any additional setup after loading the view.
        
        if let transaction = transaction {
            navigationItem.title = transaction.name
            nameTextField.text = transaction.name
            amountTextField.text = transaction.amount.asLocaleCurrency
            descriptionTextField.text = transaction.desc
            
            //converts NSDate into NSString
            let formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let datePrefix: String = formatter.stringFromDate(transaction.date)
            dateTextField.text = datePrefix
        }
        
        checkValidTransaction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITextFieldDelegate
    
    //Text Field: When pressing the return button on the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //Text Field: When editing is ended
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTransaction()
    }
    
    //Text Field is selected to edit
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    
    func checkValidTransaction(){
        let name = nameTextField.text ?? ""
        let amount = amountTextField.text ?? ""
        saveButton.enabled = !name.isEmpty && !amount.isEmpty
    }
    
    
    
    

    // MARK: - Navigation
    
    var transaction: Expense?

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(saveButton === sender){
            let name = nameTextField.text ?? ""
            let amount = amountTextField.text
            let date = NSDate()
            let description = descriptionTextField.text ?? ""
            
            var amt = NSDecimalNumber(string: amount)
            if(amt == NSDecimalNumber.notANumber()){
                amt = NSDecimalNumber(int: 0)
            }
            
            transaction = Expense(name: name, amount: amt, desc: description, date: date, repeating: false)
        }
    }


}
