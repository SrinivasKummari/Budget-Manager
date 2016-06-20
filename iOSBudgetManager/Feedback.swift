//
//  Feedback.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 9/24/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Feedback: UIViewController {

    var array = [String]()
    var jsonArray : String = ""
    
    
    
    @IBOutlet weak var feedback: UILabel!
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
             // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
//        share.budget += [Budgets(timeFrame: share.selectedTimeFrame, records: share.budgetCopy)]
        for(var i=0; i < share.budgetCopy.count; i++)
        {
            jsonArray += "\(share.budgetCopy[i].category),\(share.budgetCopy[i].budgeted)" ;
            if(i != share.budgetCopy.count-1)
            {
                jsonArray += ","
            }
            
        }
        
        
        array += [jsonArray]
        println("\(jsonArray)")
        println("Super")
        
        var url: NSString = "http://198.209.246.96/budgetmanager/budgetInsertion.php?b=\(jsonArray)&u=\(share.userEmail)&a=\(share.accountType)&m=\(share.selectedMonth)&y=\(share.selectedYear)"
        println(url)
        var urlStr : NSString = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        var searchURL : NSURL = NSURL(string: urlStr as String)!
        var data1 = NSData(contentsOfURL: searchURL)
        var result = NSString(data: data1!, encoding: NSUTF8StringEncoding)

        
        
        
        println("New budget created for \(share.selectedTimeFrame)")
        feedback.text = "New budget created for \(share.selectedTimeFrame)"
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
