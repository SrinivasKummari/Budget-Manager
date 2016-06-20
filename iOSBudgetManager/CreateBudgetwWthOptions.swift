//
//  CreateBudgetwWthOptions.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class CreateBudgetwWthOptions: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var BudgetList: UITableView!
    
 
    
    
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //share.timeFrame = "July 2015"
//        for var i = 0; i < share.budget.count ; i++
//        {
//            if( share.budget[i].period == share.timeFrame)
//            {
//                share.budgetIndex = i
//                share.budgetCopy = share.budget[i].list
//            }
//            
//        }
//        for var i = 0; i < share.budgetCopy.count ; i++
//        {
//            share.budgetCopy[i].left = share.budgetCopy[i].budgeted
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Create Budget"
        
        println("In the cration page the values are:")
        for(var i=0; i < share.budgetCopy.count; i++)
        {
            println("\(share.budgetCopy[i].category) ,\(share.budgetCopy[i].budgeted), \(share.budgetCopy[i].left)")
        }
        
        
        BudgetList.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return share.budgetCopy.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        var cell : TableViewCellTextfileds = BudgetList.dequeueReusableCellWithIdentifier("cell") as! TableViewCellTextfileds
        cell.configure(share.budgetCopy[indexPath.row].category, text: "$\(share.budgetCopy[indexPath.row].budgeted)"  )
    
    return cell
    
    
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
         share.index = indexPath.row
        
    }

    func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        
        share.index = indexPath.row
        
        
    }
    
    @IBAction func CancelAction(sender: UIBarButtonItem) {
        
        
        let alertView = UIAlertController(title: "Alert!", message: "Created budget will not be saved. Are You sure you want to cancel?", preferredStyle: .ActionSheet)
        
        let deleteAction = UIAlertAction (title: "Ok", style: .Destructive ) { alertAction in
            self.dismissViewControllerAnimated(true, completion: nil)
           // self.performSegueWithIdentifier("Budget", sender: self )
        }
        
        let cancelAction = UIAlertAction (title: "Cancel", style: .Cancel ) {  alertAction in
            
        }
        
        alertView.addAction(deleteAction)
        alertView.addAction(cancelAction)
        
        self.presentViewController(alertView, animated: true, completion: nil)
//        var alert = UIAlertView(title: "Missing Data", message: "Please enter the UserID and Passsword", delegate: nil, cancelButtonTitle: "ok")
//        alert.show()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if(segue.identifier == "edit")
        {
            var next : ChangeBudgetForCategory = segue.destinationViewController as! ChangeBudgetForCategory
            
            next.Previous = self
            
        }
        
        if(segue.identifier == "select" )
        {
            var choose : ChooseExistingMonth = segue.destinationViewController as! ChooseExistingMonth
            choose.name = self
            
            
            
        }
        
        
    
    }
    
    
    func addToBudget(categoryName : String, leftAmount : Double, budgetAmount : Double)
    {
        share.budgetCopy += [RecordExpenses(category: categoryName, imageString: "home.png", left: leftAmount, budgeted: budgetAmount, TransactionRecords: [])]
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
    {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            share.budgetCopy.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
        
        
    }
    
    
 /*   @IBAction func Create(sender: UIBarButtonItem)
    
    {
        
        
        share.budget += [Budgets(timeFrame: share.selectedTimeFrame, records: share.budgetCopy)]
        println("New budget created for \(share.selectedTimeFrame)")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    */
    
    func replaceTimeFrame(time :String)
    {
        
        for var i = 0; i < share.budget.count ; i++
        {
            if( share.budget[i].period == time)
            {
                share.budgetIndex = i
                share.budgetCopy = share.budget[i].list
            }
            
        }
        
        
    }

    
}
