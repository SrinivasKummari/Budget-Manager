//
//  AlterBudget.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class AlterBudget: UIViewController, UITableViewDataSource , UITableViewDelegate{
    
    
    @IBOutlet weak var monthname: UILabel!
    
    @IBOutlet weak var budgetList: UITableView!
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var records : [RecordExpenses] = []
    var budget : Budgets!
    var leftamount : Double = 0
    var ChangedBudget : Double = 0
    var listindex : [Int] = []
    var OriginalAmount : [Double] = []
    var OriginalLeft : [Double] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        println("\nThe selected time frame is : \(share.timeFrameAlter)\n")
        println("\nThe selected time frame is : \(share.tmonth) \(share.tyear)\n")
        share.budget = []
        share.loadData()
        /**  Bringing  budgets from app Delegate **/
        for(var i=0;  i < share.budget.count ; i++)
        {
            if(share.timeFrameAlter == share.budget[i].period)
            {
                share.budgetIndexAlter = i
                budget = share.budget[i]
                println("The index value is:\(i)")
                
            }
        }
        
        
        
        
        
        
        share.recordExpenses = budget.list
        monthname.text = share.timeFrameAlter
        for var i = 0; i < share.recordExpenses.count ; i++
        {
            
            println("\nShare category = \(share.recordExpenses[i].category) , Share budget = \(share.recordExpenses[i].budgeted)")
            
        }
        println("\nLoaded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(animated: Bool)
    {
        budgetList.reloadData()
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : AlterCellContent = budgetList.dequeueReusableCellWithIdentifier("cell") as! AlterCellContent
        cell.configure(budget.list[indexPath.row].category, text:"$\(budget.list[indexPath.row].budgeted)" )
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("number of budgets in app del budget:\(share.budget.count) ")
        println("number of categories for the current month::: \(share.budget[share.budgetIndexAlter].list.count)")
        println("cats in bud 2: \(share.budget[1].list.count)")
        return share.budget[share.budgetIndexAlter].list.count
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        share.indexAlter = indexPath.row
        
        
    }
    
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            budget.list.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
//        
//        
//    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if(segue.identifier ==  "Alter")
        {
            var change : AlterBudgetAmount = segue.destinationViewController as! AlterBudgetAmount
            
            change.alter = self
        }
            
        else if (segue.identifier == "addCategory")
            
        {
            
            var view : AlterBudgetAddCategory = segue.destinationViewController as! AlterBudgetAddCategory
            view.name = self
            
            
        }
        
    }
    
    
    
    @IBAction func Cancel(sender: AnyObject) {
        
        println("\n\n The budget was unaltered")
        
        for(var i = 0 ; i < OriginalAmount.count ; i++)
        {
            
            share.budget[share.budgetIndexAlter].list[listindex[i]].budgeted = OriginalAmount[i]
            share.budget[share.budgetIndexAlter].list[listindex[i]].left = OriginalLeft[i]
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func SaveChanges(sender: UIButton)
    {
        println("\n\n The changed budget is")
        //budget.list = share.recordExpenses
        share.budget[share.budgetIndexAlter].list = budget.list
        //        for var i = 0; i < share.budget[share.budgetIndex].list.count ; i++
        //        {
        //
        //            println("\ncategory = \(share.budget[share.budgetIndexAlter].list[i].category) , budget = \(share.budget[share.budgetIndexAlter].list[i].budgeted)")
        //
        //        }
        
        
        var budasJSON : [AnyObject] = []
        
        
        var cats:[AnyObject] = (share.budgets[share.budgetIndexAlter].valueForKey("categories") as? Array)!
        
        var str : String = ""
        for(var i=0;i<cats.count;i++){
            //var budCatId=cats.
           
            var budCatId=cats[i].valueForKey("bc_id") as! String
            println("bug cat id is: \(budCatId)")
            str=str + budCatId
            str = str + "*" + budget.list[i].category
            str = str + "*" + budget.list[i].left.description
            str = str + "*" + budget.list[i].budgeted.description+","
            
        }
        var budCount=budget.list.count-1
        if(budget.list.count>cats.count){
            str=str +  "na"
            str = str + "*" + budget.list[budCount].category
            str = str + "*" + budget.list[budCount].left.description
            str = str + "*" + budget.list[budCount].budgeted.description+","
            
        }
        let str1 : [String: AnyObject] = [
            "userDetails" :[
                "email": (share.userEmail),
                "acctType":(share.accountType),
                "timeframe": (budget.period) ],
            "Category" : str]
        //let jsonObject:[AnyObject] = [ str1     ]
        let jsonObject:[AnyObject] = [str]
        
        println("is valid json--"+NSJSONSerialization.isValidJSONObject(jsonObject).description)
        
        
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://198.209.246.96/budgetmanager/updateBudget.php")!)
        
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        if let serializedData = NSJSONSerialization.dataWithJSONObject(jsonObject, options: nil, error: &err){
            request.HTTPBody = serializedData
            println("request:\(request.HTTPBody)")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            // println("Body: \(strData)")
            var err: NSError?
            
            //var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as! NSArray
            // var json = noWrappedJson!
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            //            if(err != nil) {
            //                println(err!.localizedDescription)
            //                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
            //                println("Error could not parse JSON: '\(jsonStr)'")
            //            }
            //            else {
            //                // The JSONObjectWithData constructor didn't return an error. But, we should still
            //                // check and make sure that json has a value using optional binding.
            //                for singleCode in json {
            //                    if let parseJSON = singleCode as? NSDictionary {
            //                        // Okay, the parsedJSON is here, let's get the value for 'success' out of it
            //                        var success = parseJSON["code"] as? String
            //                        println("Succes: \(success)")
            //                    }
            //                    else {
            //                        // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
            //                        let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
            //                        println("Error could not parse JSON: \(jsonStr)")
            //                    }
            //                }
            //     }
        })
        task.resume()
        
        
        
        
        
        
        //            println("is valid json--"+NSJSONSerialization.isValidJSONObject(budasNSArray).description)
        //    println("after converting as NSARRAY\(budasNSArray[0])")
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func  saveAmount(changeAmount : Double  , leftAmount : Double, index: Int, originalbudget : Double, originalleft : Double  )
    {
        budget.list[share.indexAlter].budgeted = changeAmount
        budget.list[share.indexAlter].left = leftAmount
        listindex += [index]
        OriginalAmount += [originalbudget]
        OriginalLeft += [originalleft]
        
        
    }
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
    }
    
    
}
