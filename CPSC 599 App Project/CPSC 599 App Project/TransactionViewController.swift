//
//  TransactionViewController.swift
//  CPSC 599 App Project
//
//  Created by Brandon Yip on 2015-11-02.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var catPicker: UIPickerView!
    
    var catData: [String] = [String]()
    var savedCatVar: String = "Total"
    var photoVar: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self;
        amountTextField.delegate = self;
        dateTextField.delegate = self;
        descriptionTextField.delegate = self;
        // Do any additional setup after loading the view.
        
        catPicker.delegate = self
        catPicker.dataSource = self
        catData = ["Total", "Shopping", "Other"]
        
        if let transaction = transaction {
            navigationItem.title = transaction.name
            nameTextField.text = transaction.name
            amountTextField.text = String(transaction.amount)
            descriptionTextField.text = transaction.desc
            photoVar = transaction.photo
            if(transaction.type == "Expense") {
                segmentControl.selectedSegmentIndex = 0
            }
            else {
                segmentControl.selectedSegmentIndex = 1
            }
            //converts NSDate into NSString
            let formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let datePrefix: String = formatter.stringFromDate(transaction.date)
            dateTextField.text = datePrefix
            
            //Chnage row for item number (0-2)
        if(transaction.category == "Shopping")
        {
            catPicker.selectRow(1, inComponent: 0, animated: true)
            savedCatVar = "Shopping"
        }
        else if(transaction.category == "Other")
        {
            catPicker.selectRow(2, inComponent: 0, animated: true)
            savedCatVar = "Other"
        }
        }
        
        
        
        
        
        checkValidTransaction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return catData.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return catData[row]
    }

    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        savedCatVar = catData[row]
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
    
    var transaction: Transaction?

    
    @IBAction func cancel(sender: UIBarButtonItem) {
        //two different ways of dismissing the view controller
        //BUG: UITabBarController is supposed to be UINavigationController but it doesn't work like that
        //print(presentingViewController)
        let isPresentingInAddTransactionMode = presentingViewController is UITabBarController
        if isPresentingInAddTransactionMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(saveButton === sender){
            var type = ""
            if(segmentControl.selectedSegmentIndex == 0){
                type = "Expense"
            } else {
                type = "Income"
            }
            
            let savedCat = savedCatVar
            let name = nameTextField.text ?? ""
            let amount = amountTextField.text ?? ""
            let date = NSDate()
            let description = descriptionTextField.text ?? ""
            
            let photo = photoVar
            var amt = NSDecimalNumber(string: amount)
            
            if(amt == NSDecimalNumber.notANumber()){
                amt = NSDecimalNumber(int: 0)
            }
            
            

            transaction = Transaction(name: name, amount: amt, desc: description, date: date, type: type, repeating: "false", photo: photo, savedCat: savedCat)
        }
    }


}
