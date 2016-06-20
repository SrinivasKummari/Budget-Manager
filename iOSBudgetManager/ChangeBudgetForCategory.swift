//
//  ChangeBudgetForCategory.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ChangeBudgetForCategory: UIViewController, UITextFieldDelegate {

    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var amount: UITextField!
    var Previous : CreateBudgetwWthOptions!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(animated: Bool) {
        
        name.text = share.budgetCopy[share.index].category
        amount.text = "\(share.budgetCopy[share.index].budgeted)"
        amount.delegate = self
        
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
            share.budgetCopy[share.index].budgeted = converted.doubleValue
            share.budgetCopy[share.index].left = converted.doubleValue
            
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
