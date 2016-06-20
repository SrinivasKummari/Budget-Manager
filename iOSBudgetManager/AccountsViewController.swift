//
//  AccountsViewController.swift
//  iOSBudgetManager
//
//  Created by Juluru,Anudeep on 7/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {
    @IBAction func changepassword(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.google.com")!)
    }
var share=UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  self.navigationItem.title = "MyAccount"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        
            navigationController!.navigationBar.barTintColor = UIColor(red: 169/255, green: 214/255, blue: 201/255, alpha: 1)
       
        
        
            var jsonResult: NSArray = dataOfJson("http://198.209.246.96/budgetmanager/account.php?email=\(share.userEmail)&accountType=\(share.accountType)")
            
            
            
            self.email.text!=jsonResult[0]["EMAIL"] as! String
            
            self.fName.text!=jsonResult[0]["First_Name"] as! String
            
            self.lName.text!=jsonResult[0]["Last_Name"]  as! String
            
            self.mobile.text!=jsonResult[0]["PHONE_NUMBER"] as! String
            
            println(self.email.text)
            
            println(self.fName.text)
            
            println(self.lName.text)
            

        
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
    
}
