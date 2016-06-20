//
//  ReportsDateSelect.swift
//  iOSBudgetManager
//
//  Created by Juluru,Anudeep on 7/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ReportsDateSelect: UIViewController {

   
    
    @IBOutlet weak var selectedMonth: UIPickerView!
    
    var timeframes : [String] = []
     var month : [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    var currentFrame = 0;
    var budgetCopy : [RecordExpenses] = []
    var selection : String!
var frames = NSArray()
    var currentMonth = NSDateFormatter()
    var currentMon : NSString!
    var currentYr = NSDateFormatter()
    var currentYear : NSString!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Reports"
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
                selectedMonth.selectRow(i,inComponent:0,animated:true)
            }
            
        }
        selectedMonth.selectRow(currentFrame,inComponent:0,animated:true)
        println(timeframes)

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

    
    
    
//    @IBOutlet weak var myDatePicker: UIDatePicker!
//    @IBAction func dateAction(sender: AnyObject) {
//        var dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "MM-yyyy"
//        var strDate = dateFormatter.stringFromDate(myDatePicker.date)
//        myDatePicker = (UIDatePicker!)strDate
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        navigationController!.navigationBar.barTintColor = UIColor(red: 169/255, green: 214/255, blue: 201/255, alpha: 1)
        
        println(timeframes)

        
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
        
    }
    @IBAction func generateReport(sender: UIButton)
    {
        var intMonth : NSString = ""
        currentMonth.dateFormat = "MM"
        currentMon = currentMonth.stringFromDate(NSDate())
        
        currentYr.dateFormat = "YYYY"
        currentYear = currentYr.stringFromDate(NSDate())
        intMonth = "\(currentMon)"
        if(selection == nil)
        {
            share.tmonth = currentMon
            share.tyear = currentYear
            
             share.timeFrame = "\(month[intMonth.integerValue-1]) \(currentYear)"
          //  selection = timeframes[currentMon.integerValue]
            performSegueWithIdentifier("Report", sender: nil)
        }
        
        else
        {
            share.timeFrame = selection
            performSegueWithIdentifier("Report", sender: nil)
        }
        
        
    }

    @IBAction func pieChartGeneration(sender: UIButton)
    {
        
        currentMonth.dateFormat = "MM"
        currentMon = currentMonth.stringFromDate(NSDate())
        
        currentYr.dateFormat = "YYYY"
        currentYear = currentYr.stringFromDate(NSDate())
        
        if(selection == nil)
        {
            share.tmonth = currentMon
            share.tyear = currentYear
            
            //  selection = timeframes[currentMon.integerValue]
            performSegueWithIdentifier("pie", sender: nil)
        }
            
        else
        {
            share.timeFrame = selection
            performSegueWithIdentifier("pie", sender: nil)
        }
        
        

        
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
    
  
    
}
