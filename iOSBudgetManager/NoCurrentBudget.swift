//
//  NoCurrentBudget.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 12/2/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class NoCurrentBudget: UIViewController {

    @IBOutlet weak var note: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
note.text = "Budget is not created for the current month"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
