//
//  AlterBudgetAmount.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class AlterBudgetAmount: UIViewController, UITextFieldDelegate {
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    @IBOutlet weak var name: UILabel!
    
    

    
    @IBOutlet weak var amount: UITextField!
    var alter : AlterBudget!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
     amount.delegate = self
        name.text = alter.budget.list[share.indexAlter].category
        amount.text = "\(alter.budget.list[share.indexAlter].budgeted)"
        
        
    }
    
    
    @IBAction func DoneEditing(sender: UIButton)
    {
        if(amount.text.isEmpty)
        {
            var alert = UIAlertView(title: "Missing Data", message: "Please enter the amount", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
        }
        else
        {
            var converted : NSString = amount.text
            converted = String(format: "%.2f", converted.doubleValue)
            println("The rounded amount is \(converted.doubleValue)")
            var previousamount : Double = alter.budget.list[share.indexAlter].budgeted
            var left : Double = alter.budget.list[share.indexAlter].left
            var spent : Double = previousamount - left
            var leftamount : Double = converted.doubleValue - spent
            alter.saveAmount(converted.doubleValue, leftAmount: leftamount, index: share.indexAlter, originalbudget: previousamount, originalleft: left)
            println("\nAfter save function has been called the values of share.recordeexpenses are:\n")
            share.recordExpenses = share.budget[share.budgetIndexAlter].list
            for var i = 0; i < share.recordExpenses.count ; i++
            {
                
                println("\ncategory = \(share.recordExpenses[i].category) , budget = \(share.recordExpenses[i].budgeted)")
                
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        
        
        
        
    }
    
    
    
    @IBAction func Back(sender: UIButton)
    {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
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
