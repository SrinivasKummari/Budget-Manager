//
//  pieChart.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 11/23/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class pieChart: UIViewController {

    
    @IBOutlet weak var pieSegment: UISegmentedControl!
    
    @IBOutlet weak var budgeted: UIView!
    
    @IBOutlet weak var spent: UIView!
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generateSelected(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.5, animations: {
                self.budgeted.alpha = 0
                self.spent.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.budgeted.alpha = 1
                self.spent.alpha = 0
            })
            
        }

        
    }

    override func viewWillAppear(animated: Bool) {
     
        
        
        self.navigationItem.title = "\(share.timeFrame)"
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
