//
//  OverviewChartViewController.swift
//  Zeal
//
//  Created by Brandon Yip on 2015-11-29.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit
import Charts

class OverviewChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var pieChart: PieChartView!
    
    var transactions = [Transaction]()
    var expenses = [Transaction]()
    override func viewDidLoad() {
        super.viewDidLoad()

        //loadSampleTransactions()
        
        if let savedTransactions = loadTransactions() {
            transactions += savedTransactions
            checkExpenses()
        } else {
            loadSampleTransactions()
        }
        setupChart()
        loadChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTransactions() -> [Transaction]?{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Transaction.ArchiveURL.path!) as? [Transaction]
    }
    
    func checkExpenses() {
        for var i = 0; i < transactions.count; i++ {
            let transaction = transactions[i]
            if(transaction.type == "Expense"){
                expenses += [transaction]
            }
        }
    }
    
    func loadSampleTransactions() {
        let photo1 = UIImage(named: "entertainment")!
        let expense1 = Transaction(name: "One Direction concert", amount: 405.25, desc: "Directioner for Lyfe", date: NSDate(), type: "Expense", repeating: "false", photo: photo1, savedCat: "Other")!
        expense1.photo = photo1
        
        let photo2 = UIImage(named: "cash")!
        let income1 = Transaction(name: "Got Paid!", amount: 480.00, desc: "Part-time job", date: NSDate(), type: "Income", repeating: "false",photo: photo2, savedCat: "Other")!
        income1.photo = photo2
        
        let photo3 = UIImage(named: "shopping")!
        let expense2 = Transaction(name: "New Jeans!", amount: 60.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false",photo: photo3, savedCat: "Shopping")!
        expense2.photo = photo3
        
        let photo4 = UIImage(named: "cash")!
        let income2 = Transaction(name: "Allowance", amount: 100.00, desc: "Given by parents", date: NSDate(), type: "Income", repeating: "false", photo: photo4, savedCat: "Other")!
        income2.photo = photo4
        
        let photo5 = UIImage(named: "food")!
        let expense3 = Transaction(name: "Bought Veggies", amount: 99.25, desc: "Eating out at restaurants", date: NSDate(), type: "Expense", repeating: "false",photo: photo5, savedCat: "Food")!
        expense3.photo = photo5
        
        let photo6 = UIImage(named: "sports")!
        let expense4 = Transaction(name: "Bought a Basketball", amount: 20.75, desc: "Sporting events", date: NSDate(), type: "Expense", repeating: "false", photo: photo6, savedCat: "Shopping")!
        expense4.photo = photo6
        
        let photo7 = UIImage(named: "gas")!
        let expense5 = Transaction(name: "Bought gas", amount: 50.58, desc: "Gas for car", date: NSDate(), type: "Expense", repeating: "false", photo:  photo7, savedCat: "Utilities")!
        expense5.photo = photo7
        
        let photo8 = UIImage(named: "cash")!
        let expense6 = Transaction(name: "Paid Tuition", amount: 500.00, desc: "Tuition", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Education")!
        expense6.photo = photo8
        
        let photo9 = UIImage(named: "shopping")!
        let expense7 = Transaction(name: "Bought a TV", amount: 609.25, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
        expense7.photo = photo9
        
        let photo10 = UIImage(named: "shopping")!
        let expense8 = Transaction(name: "Bought a sweater", amount: 59.99, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
        expense8.photo = photo10
        
        let photo11 = UIImage(named: "shopping")!
        let expense9 = Transaction(name: "Bought shoes", amount: 202.09, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
        expense9.photo = photo11
        
        let photo12 = UIImage(named: "shopping")!
        let expense10 = Transaction(name: "Bought OD T-Shirt", amount: 80.00, desc: "shopping", date: NSDate(), type: "Expense", repeating: "false", photo:  photo8, savedCat: "Shopping")!
        expense10.photo = photo12
        
        expenses += [expense1, expense2, expense3, expense4, expense5, expense6, expense7, expense8, expense9, expense10]
    }
    
    func setupChart() {
        pieChart.delegate = self
        pieChart.holeTransparent = true
        pieChart.holeRadiusPercent = 0.60
        pieChart.transparentCircleRadiusPercent = 0.60
        pieChart.holeColor = pieChart.backgroundColor
        
        pieChart.userInteractionEnabled = true
        pieChart.drawSliceTextEnabled = false
        pieChart.drawHoleEnabled = true
        pieChart.drawCenterTextEnabled = true
        pieChart.legend.enabled = true
        pieChart.descriptionText = ""
        pieChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)
        
        
    }
    
    
    
    func loadChart() {

        var categories = [String]()
        for var i = 0; i < expenses.count; i++ {
            let expense = expenses[i]
            //CHANGE IF WE IMPLEMENT CATEGORIES
            if(!categories.contains(expense.category)){
                categories.append(expense.category)
            }
        }
        let count = categories.count
        
        var yVals1 = [ChartDataEntry]()
        
        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        for var i = 0; i < count; i++
        {
            let expense = expenses[i]
            let chartDataEntry = ChartDataEntry(value: Double(expense.amount), xIndex: i)
            yVals1.append(chartDataEntry)
            
        }
        
        
        var xVals = [String?]()
        
        for var i = 0; i < count; i++
        {
            xVals.append(categories[i])
            //[xVals addObject:parties[i % parties.count]]
        }
        
        let dataSet = PieChartDataSet(yVals: yVals1, label: "")
        dataSet.sliceSpace = 3.0
        
        // add a lot of colors
        
        var testColors = [UIColor]()
        testColors.append(UIColor(red: 254.0/255.0, green: 154.0/255.0, blue: 157.0/255.0, alpha: 1.0)) //red color
        testColors.append(UIColor(red: 255.0/255.0, green: 187.0/255.0, blue: 155.0/255.0, alpha: 1.0)) //orange color
        testColors.append(UIColor(red: 255.0/255.0, green: 233.0/255.0, blue: 155.0/255.0, alpha: 1.0)) //yellow color
        testColors.append(UIColor(red: 140.0/255.0, green: 181.0/255.0, blue: 221.0/255.0, alpha: 1.0)) // blue color
        testColors.append(UIColor(red: 232.0/255.0, green: 141.0/255.0, blue: 202.0/255.0, alpha: 1.0)) //pink color
        testColors.append(UIColor(red: 194.0/255.0, green: 139.0/255.0, blue: 222.0/255.0, alpha: 1.0)) //purple color
        let data = PieChartData(xVals: xVals, dataSet: dataSet)
        
        pieChart.data = data
        
        dataSet.colors = testColors
        dataSet.drawValuesEnabled = true
        dataSet.valueTextColor = UIColor.blackColor()
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "es_CL")
        dataSet.valueFormatter = formatter
        
        dataSet.sliceSpace = 3.0

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
