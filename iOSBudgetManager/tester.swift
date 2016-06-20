//
//  tester.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/13/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class tester: UIViewController {

    
    
    
    @IBOutlet weak var dateString: UITextField!
    let dateFormat: NSDateFormatter = NSDateFormatter()
    let datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormat.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormat.timeStyle = NSDateFormatterStyle.ShortStyle
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        datePicker.addTarget(self, action: Selector("updateDateField:"), forControlEvents:UIControlEvents.ValueChanged)
        dateString.inputView = datePicker
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
