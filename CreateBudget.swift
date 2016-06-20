//
//  CreateBudget.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class CreateBudget: UIViewController {

    @IBOutlet weak var datepicker: UIDatePicker!
    var dateselected : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        
        datepicker.addTarget(self, action: Selector("change:"), forControlEvents: UIControlEvents.ValueChanged)
   
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
       // dateselected = dateFormatter.stringFromDate(datePickerView.date)
        println(dateselected)
    }
    
    func change(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        dateselected = strDate
        
        println(dateselected)
        
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
