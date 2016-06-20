//
//  AlterBudgetSelection.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 10/6/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class AlterBudgetSelection: UIViewController {

    var frames = NSArray()
    var timeframes : [String] = []
    
    @IBOutlet weak var monthSelector: UIPickerView!
    var currentYr = NSDateFormatter()
    var currentYear1 : NSString!
    var currentFrame = 0
    
   
    var months : [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
    
    var month : [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
    
    var share  =  UIApplication.sharedApplication().delegate as! AppDelegate
    var year : [Int] = [2015, 2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026 ]
    var selection : String = ""
    var yearstart : NSString! = "2015"
    var yearcheck : NSString!
    var currentYear = NSDateFormatter()
    var currentMonth = NSDateFormatter()
    var currentMon : NSString!
      var budgetPeriod : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        currentYear.dateFormat = "yyyy"
//        yearcheck = currentYear.stringFromDate(NSDate())
//        
//        currentMonth.dateFormat = "MM"
//        currentMon = currentMonth.stringFromDate(NSDate())
//        
//        println("The current year is: \(yearcheck.integerValue) and the current month is: \(currentMon.integerValue) ")
//        for var i = 0 ; i < share.budget.count ; i++
//        {
//            var period = share.budget[i].period
//            var periodarray = split(period) {$0 == " "}
//            var month: NSString = "\(periodarray[0])"
//            var year: NSString = "\(periodarray[1])"
//            
//            var monthnumber : Int = 0
//            for(var k=0; k < months.count; k++ )
//            {
//                if(month == months[k])
//                {
//                    
//                    monthnumber = k + 1
//                }
//            }
//            
//            if(yearcheck.integerValue == year.integerValue && currentMon.integerValue <= monthnumber )
//            {
//                budgetPeriod += [share.budget[i].period]
//                
//                
//            }
//            else if(yearcheck.integerValue < year.integerValue)
//            {
//                budgetPeriod += [share.budget[i].period]
//            }
//            
//            
//        }
//        
//        println(budgetPeriod)

        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        
        
        frames  = dataOfJson("http://198.209.246.96/budgetmanager/LoadTimeFrame.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(components.month)&year=\(components.year)");
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
            if(year.integerValue > components.year){
            timeframes += ["\(monthName) \(year)"]
            }else if(month.integerValue>=components.month && year.integerValue==components.year){
                timeframes += ["\(monthName) \(year)"]
            }
            println(i)
        }
        currentMonth.dateFormat = "MMMM"
        currentMon = currentMonth.stringFromDate(NSDate())
        
        currentYr.dateFormat = "YYYY"
        currentYear1 = currentYr.stringFromDate(NSDate())
        for var i = 0 ;  i < timeframes.count ; i++
        {
            if(timeframes[i] == "\(currentMon) \(currentYear)")
            {
                currentFrame = i
                println("Enter the current frame")
                monthSelector.selectRow(i,inComponent:0,animated:true)
            }
            
        }
        monthSelector.selectRow(currentFrame,inComponent:0,animated:true)
        
        println(timeframes)
        

        
    }
    
    
    
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
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
    @IBAction func alterBudget(sender: AnyObject)
    {
        if (selection == "" )
        {
            
            for var i = 0 ;  i < timeframes.count ; i++
            {
                if(timeframes[i] == "\(currentMon) \(currentYear)")
                {
                    currentFrame = i
                    println("Enter the current frame")
                    monthSelector.selectRow(i,inComponent:0,animated:true)
                }
                
            }
                        selection = timeframes[currentFrame]
            
        }
        else
        {
       
        share.timeFrameAlter = selection
        println("\nLoading the time frame for \(share.timeFrameAlter)")
        performSegueWithIdentifier("alter", sender: nil)
        }
        
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
        println("month number: \(monName)")
        share.tmonth = monName
        
        var yearNum : NSString = fullNameArr[1]
        println("year number: \(yearNum)")
        share.alterYear=yearNum.integerValue
        share.alterMonth=monName.integerValue
        share.tyear = yearNum
        println("the time frame selected is:\(selection)")
        //self.View(self)
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
