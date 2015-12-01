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
    
    var expenses = [Transaction]()
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleTransactions()
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
    
    func loadSampleTransactions() {
        let expense1 = Transaction(name: "Gift", amount: 45.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false")!
        let expense2 = Transaction(name: "Shopping", amount: 60.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false")!
        let expense3 = Transaction(name: "Food", amount: 99.25, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false")!
        let expense4 = Transaction(name: "Sports", amount: 20.75, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false")!
        let expense5 = Transaction(name: "Fuel", amount: 30.58, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false")!
        let expense6 = Transaction(name: "Kids", amount: 300, desc: "Gift for friend", date: NSDate(), type: "Expense", repeating: "false")!
        
        expenses += [expense1, expense2, expense3, expense4, expense5, expense6]
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
        pieChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: ChartEasingOption.EaseOutBack)
        
        
    }
    
    
    
    func loadChart() {

        var categories = [String]()
        for var i = 0; i < expenses.count; i++ {
            let expense = expenses[i]
            //CHANGE IF WE IMPLEMENT CATEGORIES
            if(!categories.contains(expense.name)){
                categories.append(expense.name)
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
