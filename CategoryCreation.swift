//
//  CategoryCreation.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/8/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class CategoryCreation: UIViewController {

   
    @IBOutlet weak var Categoryname: UITextField!
    
    var id : Category!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Createone(sender: UIButton) {
        
        if(Categoryname.text.isEmpty)
        {
            var alert = UIAlertView(title: "Missing Data", message: "Please enter the Category Name", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
        }
        else
        {
            id.save(Categoryname.text.capitalizedString)
        }

        
    }

    
    @IBAction func Cancel(sender: UIButton)
    {
        
        id.exit()
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
