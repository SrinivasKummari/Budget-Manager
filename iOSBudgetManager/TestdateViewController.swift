//
//  TestdateViewController.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/13/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class TestdateViewController: UIViewController {

 
   
    @IBOutlet weak var datestring: UITextField!
    
    
       func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        datestring.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
    }}
