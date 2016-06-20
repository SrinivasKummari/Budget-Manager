//
//  AddCategoryToBudget.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class AddCategoryToBudget: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var categoryList: UIPickerView!
    
    
    
    @IBOutlet weak var amount1: UITextField!
    
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    var selection : String!
    var name : CreateBudgetwWthOptions!
    var flag = 0
    override func viewDidLoad() {
        var Category1 : NSArray = dataOfJson("http://198.209.246.96/budgetmanager/categories.php?email=\(share.userEmail)&accountType=\(share.accountType)");
        share.Category1=Category1
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool)
    {
      
        amount1.delegate = self
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func AddCategory(sender: UIButton)
    {
        print(selection)
        print("Selection value is printed above")
        if(selection == nil || amount1.text.isEmpty  )
        {
            var alert = UIAlertView(title: "Missing Data", message: "Please enter all the fields", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            
        }
        else
        {
            
            var samount : NSString = amount1.text
            samount = String(format: "%.2f", samount.doubleValue)
            var rec : RecordExpenses = RecordExpenses(category: selection, imageString: "home.png", left: samount.doubleValue, budgeted: samount.doubleValue, TransactionRecords: [])
            for var i = 0 ; i < share.budgetCopy.count; i++
            {
                if(share.budgetCopy[i].category == selection)
                {
                    flag = 1
                }
             }
            
            if(flag != 1)
            {
                    share.budgetCopy += [rec]
            println("The new category is added and the budget looks like this")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            else
            {
                var alert = UIAlertView(title: "Duplicate Category", message: "Category Which you have selected already exists!!!", delegate: nil, cancelButtonTitle: "ok")
                alert.show()
                
            }
//            name.addToBudget(selection, leftAmount: samount.doubleValue, budgetAmount: samount.doubleValue)
            
           
            
        }

        
        
    }

    
    @IBAction func Cancel(sender: UIButton)
    {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        
        return 1
    }
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return share.Category1.count    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        
        return share.Category1[row]["CATEGORY_NAME"] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        selection =  share.Category1[row]["CATEGORY_NAME"] as? String
        println(selection)
        
        
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        if (textField == amount1)
        {
            if count(string) > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        
        
        
        return result
    }


}
