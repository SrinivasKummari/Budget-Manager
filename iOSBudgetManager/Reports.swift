//
//  Reports.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/12/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Reports: UIViewController {

    
  //  let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)

    var share = UIApplication.sharedApplication().delegate as! AppDelegate
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
      //  navigationController!.navigationBar.barTintColor = UIColor(red: 169/255, green: 214/255, blue: 201/255, alpha: 1)
//        var DynamicView=GraphView()
//        self.view.addSubview(DynamicView)
        self.navigationItem.title = "\(share.timeFrame)"
                //self.navigationController?.title = "Report: \(share.timeFrame)"
    }
    
    
//
//    override func loadView() {
//        self.view = self.scrollView
//        self.scrollView.contentSize = CGSize(width:1234, height: 5678)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
