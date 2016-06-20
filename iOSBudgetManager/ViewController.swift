//
//  ViewController.swift
//  iOSBudgetManager
//
//  Created by Juluru,Anudeep on 6/29/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    let date = NSDate()
    let calendar = NSCalendar.currentCalendar()
    
    @IBOutlet weak var userid: UITextField!
    @IBOutlet weak var password: UITextField!
    
 var userCheck=0
    var data: NSArray = []

    @IBOutlet weak var scrollView1: UIScrollView!
    
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.userid.delegate = self
       self.password.delegate = self
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        navigationController!.navigationBar.barTintColor = UIColor(red: 169/255, green: 214/255, blue: 201/255, alpha: 1)
    }

    @IBAction func Welcomesignin(sender: UIButton)
    {
        
        if(userid.text.isEmpty || password.text.isEmpty )
        {
            var alert = UIAlertView(title: "Missing Data", message: "Please enter the UserID and Passsword", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
        }
        else{
            println("in else block")
             data=dataOfJson("http://198.209.246.96/budgetmanager/login.php");
            for user in data{
                //println("in JSON result for loop")
                var userMail = user["EMAIL"] as! String
                println("userMail Value: \(userMail)")
                println("Entered userid Value: \(self.userid.text)")
                var userPass = user["PASSWORD"] as! String
                println("Entered userPass Value: \(self.password.text)")
                println("userPass Value: \(userPass)")
                if(self.userid.text == userMail && self.password.text == userPass){
                    //self.callAccountSelectionViewController();
                   
                    println("condition satisfied and value incremented")
                    share.userEmail=userid.text
                    userCheck=1
                    println("userCheck Value: \(userCheck)")
                    
                    //var mystory:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    //var accSelect = mystory.instantiateViewControllerWithIdentifier("accountselect") as! accountselection
                    //gov.gvc=self
                    // println(navigationController)
                    
                    //self.presentViewController(accSelect, animated: true, completion: nil)
                    //                        let accSelect = self.storyboard?.instantiateViewControllerWithIdentifier("accountselect") as! accountselection
                    //                        self.navigationController?.pushViewController(accSelect, animated: true)
                    
                    
                }
            }
            userValueCheck()
        }
        
        
        
        
    }
    
    func userValueCheck(){
        if(userCheck==1){
            println("user check value: \(userCheck)")
            performSegueWithIdentifier("accounts", sender: nil)
        }else{
            println("user check value in else condition: \(userCheck)")
            println("Condition failed")
            var alert = UIAlertView(title: "Missing Data", message: "UserID and passwords don't match", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
            userid.text = ""
            password.text = ""
            userid.becomeFirstResponder()
        }
    }
    
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        println("Enter")
//        if(segue.identifier == "accounts")
//        {
//            println("Maroon 5")
//            var account : accountselection = segue.destinationViewController as! accountselection
//        }
//
//    
//    }
    @IBAction func Forgotpassword(sender: UIButton)
    {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://198.209.246.96/sslconnection/forgotpwd.html")!)
        
    }

    @IBAction func Openregistration(sender: UIButton)
    {
        
      
        
        UIApplication.sharedApplication().openURL(NSURL(string: "http://198.209.246.96/sslconnection/registration.html")!)
    
    }
  
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
       return true
        
    }
    @IBAction func logout(segue: UIStoryboardSegue){
        
    }
}

