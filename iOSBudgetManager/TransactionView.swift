//
//  TransactionView.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class TransactionView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var transactionView: UITableView!
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    var main : ViewBudget!
    var transactions = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        var categoryName = share.currentBudget[share.transactionIndex]["catName"] as! NSString
       transactionView.tableFooterView = UIView(frame: CGRectZero)
       transactions =  dataOfJson("http://198.209.246.96/budgetmanager/transactions.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(share.tmonth)&year=\(share.tyear)&catName=\(categoryName)");
        if(transactions[0] as! NSObject == 0)
        {
            transactions = []
        }
        println("\(transactions)")
      transactionView.reloadData()
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
      
        var cell : TransactionCell =  transactionView.dequeueReusableCellWithIdentifier("cell") as! TransactionCell
        var title = transactions[indexPath.row]["TITLE"] as! String
        var date = transactions[indexPath.row]["TRANSACTION_DATE"] as! String
        var transactionAmount = transactions[indexPath.row]["AMOUNT"] as! NSString
        cell.configure(title, Date: date, Tamount: transactionAmount.doubleValue)
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return transactions.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    @IBAction func Back(sender: UIButton)
    {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
 
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
    }


   
}
