//
//  ChooseExistingMonth.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ChooseExistingMonth: UIViewController, UIPickerViewDataSource {

    
    @IBOutlet weak var duration: UIPickerView!
    var timeframes : [String] = []
     var month : [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    var frames = NSArray()
        var selection : String!
    var name : CreateBudgetwWthOptions!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //navigationController!.navigationBar.barTintColor = UIColor(red: 169/255, green: 214/255, blue: 201/255, alpha: 1)
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
            return NSComparisonResult.OrderedDescending
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
        
        println(timeframes)
        

    }
    

    @IBAction func SelectMonth(sender: UIButton)
    
    {
        if (selection == nil )
        {
            
            var alert = UIAlertView(title: "Missing Data", message: "Please Select the timeframe to copy the budget", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            
        }
        else
        {
                   var budgetToCopy = dataOfJson("http://198.209.246.96/budgetmanager/currentBudget.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(share.tmonth)&year=\(share.tyear)");
            println("\(budgetToCopy)")
            share.budgetCopy = []
            for var i=0; i < budgetToCopy.count; i++
            {
                var catName = budgetToCopy[i]["catName"] as! String
               var budgeted : NSString = share.currentBudget[i]["amountAlotted"] as! NSString
                var icon = share.currentBudget[i]["icon"] as? String
                if(icon == nil)
                {
                    icon = "others.png"
                    println("Category icon name is \(icon)")
                }
                share.budgetCopy += [RecordExpenses(category: catName, imageString: icon!, left: budgeted.doubleValue, budgeted: budgeted.doubleValue, TransactionRecords: [])]
                
                
                
            }
            
            
            self.dismissViewControllerAnimated(true, completion: nil)

        }
        
        
        
        
        
        
    }
        
        

    
    
    
    
    
    
    
@IBAction func back(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
   
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    
    
    
}
