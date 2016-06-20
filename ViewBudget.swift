//
//  ViewBudget.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ViewBudget: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var duration: UIPickerView!
    @IBOutlet weak var clabel: UILabel!
    
    @IBOutlet weak var list: UITableView!
    @IBOutlet weak var blabel: UILabel!
    @IBOutlet weak var leftlabel: UILabel!
   
    var pickerIdentifier: String?
    var currentMonth = NSDateFormatter()
    var currentMon : NSString!
    var currentYr = NSDateFormatter()
    var currentYear : NSString!
    var currentFrame = 0
//    @IBOutlet weak var catLBL: UILabel!
//    
//    @IBOutlet weak var lLBL: UILabel!
// 
//    @IBOutlet weak var BLBL: UILabel!
    var month : [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
    var categoryLBL:UILabel!
    var leftLBL:UILabel!
    var budgetLBL:UILabel!
    
    var timeframes : [String] = []
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var budgetCopy : [RecordExpenses] = []
    var selection : String!
    var frames = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        list.tableFooterView = UIView(frame: CGRectZero)
        
        frames  = dataOfJson("http://198.209.246.96/budgetmanager/LoadTimeFrame.php?email=\(share.userEmail)&accountType=\(share.accountType)");
        println("\(frames)")
        frames =  frames.sortedArrayUsingComparator(){
            
            (p1:AnyObject!, p2:AnyObject!) -> NSComparisonResult in
            
            if (p1["YEAR"] as! NSString).integerValue > (p2["YEAR"] as! NSString).integerValue{
                return NSComparisonResult.OrderedDescending
            }
            if (p1["YEAR"] as! NSString).integerValue < (p2["YEAR"] as! NSString).integerValue {
                return NSComparisonResult.OrderedAscending
            }
            return NSComparisonResult.OrderedAscending
        }
        frames =  frames.sortedArrayUsingComparator(){
            
            (p1:AnyObject!, p2:AnyObject!) -> NSComparisonResult in
            
            if (p1["MONTH"] as! NSString).integerValue > (p2["MONTH"] as! NSString).integerValue{
                return NSComparisonResult.OrderedDescending
            }
            if (p1["MONTH"] as! NSString).integerValue < (p2["MONTH"] as! NSString).integerValue {
                return NSComparisonResult.OrderedAscending
            }
            return NSComparisonResult.OrderedAscending
        }
        
        
        for var i = 0 ; i < frames.count ; i++
        {
            var month = frames[i]["MONTH"] as! NSString
            var year = frames[i]["YEAR"] as! NSString
            var monthName = name(month)
            println("Month: \(month) and year : \(year)")
            timeframes += ["\(monthName) \(year)"]
            println(i)
        }
        currentMonth.dateFormat = "MMMM"
        currentMon = currentMonth.stringFromDate(NSDate())
        
        currentYr.dateFormat = "YYYY"
        currentYear = currentYr.stringFromDate(NSDate())
        for var i = 0 ;  i < timeframes.count ; i++
        {
            if(timeframes[i] == "\(currentMon) \(currentYear)")
            {
                currentFrame = i
                println("Enter the current frame")
                // duration.selectRow(i,inComponent:0,animated:true)
            }
            
        }
        duration.selectRow(currentFrame,inComponent:0,animated:true)
        share.currentBudget = []
    }
    override func viewWillAppear(animated: Bool) {

        
        
        selection = nil
        list.reloadData()
        println(timeframes)
    }
 func View(sender: AnyObject)
    {
        currentMonth.dateFormat = "MM"
        currentMon = currentMonth.stringFromDate(NSDate())
        
        currentYr.dateFormat = "YYYY"
        currentYear = currentYr.stringFromDate(NSDate())
      if (selection==nil)
      {
       
        share.tmonth = currentMon
        share.tyear = currentYear
        selection = "\(currentMon) \(currentYear)"
        
       }
       else
      {
       
        clabel.text = "Category"
        leftlabel.text = "Left"
        blabel.text = "Budget"
        share.currentBudget = dataOfJson("http://198.209.246.96/budgetmanager/currentBudget.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(share.tmonth)&year=\(share.tyear)");
//        for var i = 0 ; i < share.budget.count ; i++
//        {
//            
//            if(share.budget[i].period == selection )
//            {
//                budgetCopy = share.budget[i].list
//                share.budgetCopy = share.budget[i].list
//                
//            }
//            
//        }
//        
//        for var i = 0; i < budgetCopy.count ; i++
//        {
//            
//            println("category = \(budgetCopy[i].category) , budget = \(budgetCopy[i].budgeted)")
//            
//        }
//        
      list.reloadData()
        
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : ViewCell! = tableView.dequeueReusableCellWithIdentifier("cell") as! ViewCell
        var budgeted : NSString = share.currentBudget[indexPath.row]["amountAlotted"] as! NSString
        var spent : NSString = share.currentBudget[indexPath.row]["amountSpent"] as! NSString
       var  categoryName = share.currentBudget[indexPath.row]["catName"] as! String

        cell.configure(categoryName, leftamount: "$\(budgeted.doubleValue-spent.doubleValue)", budgetamount: "$\(budgeted.doubleValue)")

        
        return cell

   }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return share.currentBudget.count
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        share.index = indexPath.row
        share.transactionIndex = indexPath.row
        
    }
    

    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        
        return 1
    }
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
            return timeframes.count
        
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        
    
        return timeframes[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selection =  timeframes[row]
        var fullNameArr = split(selection) {$0 == " "}
        var monName: NSString = fullNameArr[0]
        
        monName = stringtoNumber(monName)
        share.tmonth = monName
        
        var yearNum : NSString = fullNameArr[1]
        share.tyear = yearNum
        println(selection)
        self.View(self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "View")
        {
            
            var transaction : TransactionView = segue.destinationViewController as! TransactionView
            transaction.main = self
            
        }
    }
    
        
        func name(name: NSString)->String
        {
            var monthName : String = ""
            for var i = 0; i<month.count ; i++
            {
                if(i == name.integerValue-1)
                {
                    monthName = month[i]
                    
                }
                
            }
            println("The month name is \(monthName)")
            return monthName
            
        }
        
        func dataOfJson(url: String) -> NSArray {
            var data = NSData(contentsOfURL: NSURL(string: url)!)!
            var error: NSError?
            var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
            //println(data)
            return jsonArray;
        }
        
    func stringtoNumber(name:NSString )->NSString
    {
        var number: NSString!
        for var i = 0; i<month.count ; i++
        {
            if(month[i] == name)
            {
                number = "\(i+1)"
                
            }
            
        }
        println("The month Number is \(number.integerValue)")
        return number
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
