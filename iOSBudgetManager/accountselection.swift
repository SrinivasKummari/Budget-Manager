//
//  accountselection.swift
//  iOSBudgetManager
//
//  Created by Student on 6/29/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class accountselection: UIViewController, UIPickerViewDelegate {
    
    var share=UIApplication.sharedApplication().delegate as! AppDelegate
    
    var account : [String] = ["Select the type","Personal", "Business"]
    var selection : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Selectaccount(sender: UIButton)
    {
        
        print(selection)
        print("Selection value is printed above")
        if(selection == nil || selection == "Select the type"  )
        {
            
            var alert = UIAlertView(title: "Missing Data", message: "Please select the account type", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            
        }
        else
        {
            if(selection == "Personal"){
                share.accountType=0
            }else{
                share.accountType=1
            }
            
           // share.loadData()
            
            performSegueWithIdentifier("selection", sender: nil)
            
        }
        
        
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //
    //        if(segue.identifier == "selection")
    //        {
    //
    //            var move : TestView = segue.destinationViewController as TestView
    //
    //        }
    //
    //
    //    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        
        return 1
    }
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return account.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        
        return account[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        selection =  account[row]
        println(selection)
        
        
    }
    @IBAction func switchAccount(segue: UIStoryboardSegue){
        
    }
    
    
}
