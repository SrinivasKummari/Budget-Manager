//
//  AlterBudgetAddCategory.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class AlterBudgetAddCategory: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var categoryList: UIPickerView!
    
    
    @IBOutlet weak var amount: UITextField!
    
    
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    var selection : String!
    var name : AlterBudget!
    var leftCats:[String]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        var Category1 : NSArray = dataOfJson("http://198.209.246.96/budgetmanager/categories.php?email=\(share.userEmail)&accountType=\(share.accountType)");
        share.Category1=Category1
        var shareBud :[AnyObject]=(share.budgets[share.budgetIndexAlter].valueForKey("categories") as? Array)!
       
        
        for(var i=0;i<Category1.count;i++){
            var count=0
     var catNamehere=Category1[i]["CATEGORY_NAME"] as? String
            println("cat name: \(catNamehere!)")
            for(var j=0;j<shareBud.count;j++){
                
                var catNamealt=shareBud[j].valueForKey("catName") as? String
                if(catNamehere!==catNamealt!){
                    count++
                }
            }
            if(count==0){
                leftCats.append(catNamehere!)
            }
        }
        if(leftCats.isEmpty)
        {
            leftCats = []
          //  var alert = UIAlertView(title: "All the created category are included in the current budget.", delegate: nil, cancelButtonTitle: "ok")
            let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "All the created category are included in the current budget. Please create the category you wish to add in the current budget"
            alert.addButtonWithTitle("Ok")
            alert.show()
            
        }
        
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
        amount.delegate = self
        
        
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
        if(selection == nil || amount.text.isEmpty  )
        {
            var alert = UIAlertView(title: "Missing Data", message: "Please enter all the fields", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            
        }
        else
        {
            
            var samount : NSString = amount.text
            samount = String(format:"%.2f", samount.doubleValue)
            name.budget.list += [RecordExpenses(category: selection, imageString: "home.png", left: samount.doubleValue, budgeted: samount.doubleValue, TransactionRecords: [])]
            self.dismissViewControllerAnimated(true, completion: nil)
            
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
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        println("category1 count: \(share.Category1.count)")
        //return share.Category1.count
        return leftCats.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
//        var catName=share.Category1[row]["CATEGORY_NAME"]
//        println("cat name: (catName)")
//        return share.Category1[row]["CATEGORY_NAME"] as? String
return leftCats[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
//        selection =  share.Category1[row]["CATEGORY_NAME"] as? String
//        println(selection)
        selection=leftCats[row]
        println("selected cat: \(selection)")
    }
    
    //    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    //    {
    //
    //        return 1
    //    }
    //    // returns the # of rows in each component..
    //    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    //    {
    //        return share.Category1.count    }
    //
    //    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    //    {
    //
    //        return share.Category1[row]
    //    }
    //
    //    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    //    {
    //
    //        selection =  share.Category1[row]
    //        println(selection)
    //
    //
    //    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
        if (textField == amount)
        {
            if (!string.isEmpty) {
                let disallowedCharacterSet = NSCharacterSet(charactersInString: "0123456789.").invertedSet
                let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
        }
        
        
        
        return result
    }
}
