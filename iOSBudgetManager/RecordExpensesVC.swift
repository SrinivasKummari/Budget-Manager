//
//  RecordExpensesVC.swift
//  iOSBudgetManager
//
//  Created by Samavedam,Shravya on 7/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class RecordExpensesVC: UIViewController, UITextFieldDelegate {
    
    
    var share=UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var textView: UITextView!
    var exp : RecordExpensesViewController!
    let date = NSDate()
    let calendar = NSCalendar.currentCalendar()
    
    

    @IBOutlet weak var expenseTitle: UITextField!
   
    @IBOutlet weak var datepicker: UIDatePicker!
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!

    var convertamount : NSString!
    var dateselected : String!
    var rec : Transactions!
    var selection : NSDate!
    
    override func viewDidLoad() {
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        let month = components.month
        let year = components.year
        let day = components.day
        super.viewDidLoad()
        textView.layer.borderWidth = 1
        
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                textView.resignFirstResponder()
                return false
            }
            return true
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        textView.layer.borderWidth = 1
        
        datepicker.addTarget(self, action: Selector("change:"), forControlEvents: UIControlEvents.ValueChanged)
        self.expenseTitle.delegate = self
        self.amount.delegate = self
        selection = self.datepicker.date
        println("selected date is \(selection)")

    
    }
    
    func change(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        

        dateFormatter.dateFormat = "MM-dd-yyyy"
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        dateselected = strDate
        
        println(dateselected)
    }

    @IBAction func Save(sender: UIButton) {
      
               if(expenseTitle.text.isEmpty || amount.text.isEmpty  )
       {
        
        var alert = UIAlertView(title: "Missing Data", message: "Please enter all the fields", delegate: nil, cancelButtonTitle: "ok")
        alert.show()
        

        }
        
        else
        {
            var amountAltered : Double = 0
            if(dateselected == nil)
            {
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                
                dateselected = dateFormatter.stringFromDate(NSDate())
                // println("If loop date: \(dateselected)")
                
            }
            
            convertamount = amount.text as NSString!
            convertamount = String(format: "%.2f", convertamount.doubleValue)
            amountAltered = convertamount.doubleValue
            println("\(expenseTitle.text), \(dateselected), \(textView.text), \(convertamount)")
           exp.save(expenseTitle.text, date: dateselected, amount: amountAltered , description: textView.text)
          
            let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
            println("cat Name: \(share.catSelected)");
            println("email: \(share.userEmail)")
            println("account Type: \(share.accountType)")
            println("b month: \(components.month)")
            println("b year: \(components.year)")
            println("title: \(expenseTitle.text)")
            println("exp date: \(selection)")
            println("spent amount: \(amount.text)")
            println("des: \(textView.text)")
            var url: NSString = "http://198.209.246.96/budgetmanager/recordExpense.php?categoryName=\(share.catSelected)&email=\(share.userEmail)&accountType=\(share.accountType)&bMonth=\(components.month)&bYear=\(components.year)&title=\(expenseTitle.text)&expDate=\(selection)&amount=\(amount.text)&desc=\(textView.text)"
            url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
            
        
            url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
            var data = NSData(contentsOfURL: NSURL(string: url as String)!)
            var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
            println("result value is: \(result)")
        
        
        }
    }
    
   
    
    @IBAction func Cancel(sender: AnyObject) {
        
        
        exp.exit()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        if (textField == amount)
        {
            if (!string.isEmpty)  {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        
        
        
        return result
    }


}