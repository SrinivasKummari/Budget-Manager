//
//  BudgetCreation.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class BudgetCreation: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{

    
    
    @IBOutlet weak var MonthSelector: UIPickerView!
    
    

    var month : [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
    var share  =  UIApplication.sharedApplication().delegate as! AppDelegate
    var year : [Int] = [2015, 2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026 ]
    var selection : String = "December"
    var selection1 : Int = 2015
    var yearstart : NSString! = "2015"
    var checkTimeFrame : NSString!
     var yearcheck : NSString!
    var count1 : Int = 0
    var currentYear = NSDateFormatter()
    var currentMonth = NSDateFormatter()
    var currentMon : NSString!
     var duplicate = NSArray()
    var element : NSObject!
    var index: NSString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonth.dateFormat = "MM"
        currentMon = currentMonth.stringFromDate(NSDate())
selection = "\(month[currentMon.integerValue-1])"
        index = "\(currentMon)"
       count1 = index.integerValue-1
        currentYear.dateFormat = "yyyy"
        yearcheck = currentYear.stringFromDate(NSDate())
        yearstart = "\(yearcheck.integerValue)"
        
               // Do any additional setup after loading the view.
    }

    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        println("\(jsonArray)")
               return jsonArray;
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
           }
    
    override func viewWillAppear(animated: Bool) {
    
        println("Default values for creation is : \(selection) \(yearstart)")
        currentYear.dateFormat = "yyyy"
        yearcheck = currentYear.stringFromDate(NSDate())
       
        currentMonth.dateFormat = "MM"
        currentMon = currentMonth.stringFromDate(NSDate())
        
        MonthSelector.selectRow((index.integerValue-1),inComponent:0,animated:true)
        
        println("The current year is: \(yearcheck.intValue) and the current month is: \(currentMon.intValue) ")
        
    }

    
    @IBAction func CreateSelection(sender: UIButton) {
       
                        share.year = Int(yearstart.intValue)
        share.month = selection
        share.selectedMonth = count1+1
        share.selectedYear = selection1
       println("\(yearstart),\(yearcheck) and \(currentMon.intValue)  \(count1)")
       // println("\(duplicate)")
        duplicate = dataOfJson("http://198.209.246.96/budgetmanager/CheckForDuplicates.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(count1+1)&year=\(selection1)") ;
        println("\(duplicate)")
        element = duplicate[0] as! NSObject;
        // Year check has the current year value and the year start has the selected component in the picker
    if(yearstart.intValue == yearcheck.intValue &&  count1 + 1 >= Int(currentMon.intValue)  )
    {
        
        println("Current Year")
        share.selectedTimeFrame = "\(selection) \(selection1)"
        println("\(element)")
        if(element == 0)
        {
        println("Duplicate check loop entered")
        performSegueWithIdentifier("Create", sender: nil)
        }
        else
        {
            var alert = UIAlertView(title: "No Duplicates allowed", message: "You have already created budget for \(selection) \(selection1) ", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
        }
        
        }
        else if(yearstart.intValue > yearcheck.intValue)
    {
        println("Future year")
        share.selectedTimeFrame = "\(selection) \(selection1)"

        if(element == 0)
        {
            println("Duplicate check loop entered")
            performSegueWithIdentifier("Create", sender: nil)
        }
        else
        {
            var alert = UIAlertView(title: "No Duplicates allowed", message: "You have already created budget for \(selection) \(selection1) ", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
        }
        

    }
       else
    {
         var monthFormater = NSDateFormatter()
        monthFormater.dateFormat = "Month"
        var eligibleMonth = currentMonth.stringFromDate(NSDate())

        var alert = UIAlertView(title: "Error", message: "You can create budgets from \(month[(eligibleMonth.toInt()!)-1]) \(yearstart)", delegate: nil, cancelButtonTitle: "ok")
        alert.show()
        
        println("Fail")
        }
    
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if(segue.identifier == "Create")
//        {
//            
//            var view : CreateBudgetwWthOptions = segue.destinationViewController as CreateBudgetwWthOptions
//            
//            
//            
//        }
//        
//        
//        
//    }
   
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        
        return 2
    }
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if (component == 0){
            return month.count
        }else{
            return year.count
    }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        
        
        
        if (component == 0){
            
            
            
            return "\(month[row])"
        }else{
            return "\(year[row])"
    }
        }
        
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(component == 0)
        {
            
                    selection =  month[row]
           
            //    println(selection)
            //println(count1)
            for var i = 0; i < month.count ; i++
                {
                    if(month[i] == selection)
                    {
                        count1 = i
                    }
                    
                 }
            println(count1)
       
        }
        else
        {
            
                selection1 =  year[row]
        
            
             yearstart  = "\(selection1)"
            println(yearstart.intValue)
        }
        
        
    }

    
 
}
