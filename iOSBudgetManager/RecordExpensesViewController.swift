//
//  RecordExpensesViewController.swift
//  iOSBudgetManager
//
//  Created by Samavedam,Shravya on 7/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class RecordExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let date = NSDate()
    let calendar = NSCalendar.currentCalendar()
    
    @IBOutlet weak var Note: UILabel!
var months : [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
    var recordExpenses=[RecordExpenses]()
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    var selectedCategory : String!
    var selectedcell : Int!
    var categoryLBL:UILabel!
    var leftLBL:UILabel!
    var budgetLBL:UILabel!
    var budget : Budgets!
    var imageView : UIImageView!
    var reqTimeFrame : String! = ""
    var tempBudget = NSArray()
    
    @IBOutlet weak var list: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        println("Loading temp")
        tempBudget  = dataOfJson("http://198.209.246.96/budgetmanager/currentBudget.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(components.month)&year=\(components.year)");
        println("temp loaded")
        if(tempBudget[0] as! NSObject == 0)
        {
            Note.text = "No budget for the current month"
            share.currentBudget = []
            println("Loop entered")
        }
        else
        {
            Note.text = "Click on the category to record expense"
            share.currentBudget=tempBudget
        }
        

        
       
        
    }
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        println(data)
        return jsonArray;
    }
    
    override func viewWillAppear(animated: Bool) {
//        self.list.backgroundColor = UIColor.greenColor()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        println("View before temp")
         tempBudget  = dataOfJson("http://198.209.246.96/budgetmanager/currentBudget.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(components.month)&year=\(components.year)");
        println("View after temp")
        if(tempBudget[0] as! NSObject == 0)
        {
            
            Note.text = "No budget for the current month"
            share.currentBudget = []
            println("Loop entered")
           // performSegueWithIdentifier("No", sender: nil)
        }
        else
        {
            Note.text = "Click on the category to record expense"
        share.currentBudget=tempBudget
        }
        
        
        list.tableFooterView = UIView(frame: CGRectZero)
        
        share.timeFrame = "October 2015"
        for var i = 0 ; i < share.budget.count ; i++
        {
            if(share.timeFrame == share.budget[i].period)
            {
                share.budgetIndex = i
                self.recordExpenses = share.budget[i].list
            }
            
        }

        list.reloadData()
    }
    
//    override func viewWillDisappear(animated: Bool) {
//        
//        share.budget[share.budgetIndex].list = recordExpenses
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return share.currentBudget.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recordexpenses", forIndexPath: indexPath) as! UITableViewCell
        //var rec:RecordExpenses=self.recordExpenses[indexPath.row]
        categoryLBL = cell.viewWithTag(1) as! UILabel
        leftLBL = cell.viewWithTag(2) as! UILabel
        budgetLBL = cell.viewWithTag(3) as! UILabel
        imageView = cell.viewWithTag(4) as! UIImageView
        var imgString:String!
        var budAmountString=share.currentBudget[indexPath.row]["amountAlotted"] as? NSString
        var budAmount=budAmountString?.doubleValue
        //var budAmount = share.currentBudget[indexPath.row]["amountAlotted"] as? NSString)!.doubleValue
        categoryLBL.text = (share.currentBudget[indexPath.row]["catName"] as? String)?.capitalizedString;
        var leftAmount = (share.currentBudget[indexPath.row]["amountAlotted"] as? NSString)!.doubleValue-(share.currentBudget[indexPath.row]["amountSpent"] as? NSString)!.doubleValue;
        
        leftLBL.text = String(format:"%.2f", leftAmount)
       
        
        budgetLBL.text = String(format:"%.2f", budAmount!)
        
        if(share.currentBudget[indexPath.row]["icon"] as? String != nil){
            
            
            imgString=share.currentBudget[indexPath.row]["icon"] as? String
            println("imagestring is \(imgString)")
        }else{
            println("in image setting else condition")
             imgString="others.png";
        }
        imageView.image = UIImage(named: imgString);
        
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "create")
        {
            var enterExpence : RecordExpensesVC = segue.destinationViewController as! RecordExpensesVC
            
            enterExpence.exp = self
            
            
        }
    }
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
   //var rec:RecordExpenses=self.recordExpenses[indexPath.row]
    var catName=share.currentBudget[indexPath.row]["catName"] as! String;
    println("selected cat name: \(catName)")
    //selectedCategory = rec.category
    share.catSelected=catName
    selectedcell = indexPath.row
    
    
        
        
    }
    
    func save( title: String, date : String, amount : Double, description: String)
    {
        
        var datespliter  = date
        var dateArray : [String] = split(datespliter) {$0 == "-"}
        var month : NSString = dateArray[0]
        var year : String = dateArray[2]
        var record = Transactions(title: title, date: date, Details: description, amount: amount)
        //        record.title = title
        //        record.date = date
        //        record.amount = amount
        //        record.Details = description
//        month = months[month.integerValue+1]
//        reqTimeFrame = "\(month) \(year)"
//        for var i = 0 ; i < share.budget.count ; i++
//        {
//            if(reqTimeFrame == share.budget[i].period)
//            {
//                share.budgetIndex = i
//                self.budget = share.budget[i]
//            }
//            
//        }
//        
//        for var i = 0 ; i < share.budget.count ; i++
//        {
//            if(reqTimeFrame == share.budget[i].period)
//            {
//                //share.budgetIndex = i
//                budget = share.budget[i]
//            }
//            
//        }
//        for var i = 0 ; i < share.budget[share.budgetIndex].list.count ; i++
//        {
//            if(share.budget[share.budgetIndex].list[i].category == recordExpenses[selectedcell].category )
//            {
//                
//                share.budget[share.budgetIndex].list[i].TransactionRecords += [record]
//                share.budget[share.budgetIndex].list[i].left -= record.amount
//            }
//            
//            
//        }
        
        
      //  recordExpenses[selectedcell].TransactionRecords += [record]
        //recordExpenses[selectedcell].left -= record.amount
       // println(recordExpenses[selectedcell].left)
        list.reloadData()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func exit()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}