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
        
        expenses += [expense1, expense2, expense3]
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
        
        
        pieChart.descriptionText = "Test"
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
        testColors.append(UIColor.blueColor())
        testColors.append(UIColor.redColor())
        testColors.append(UIColor.greenColor())
        testColors.append(UIColor.yellowColor())
        testColors.append(UIColor.purpleColor())
        let data = PieChartData(xVals: xVals, dataSet: dataSet)
        
        pieChart.data = data
        
        dataSet.colors = testColors
        dataSet.drawValuesEnabled = true
        
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
