//
//  Tableviewtest.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/8/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Tableviewtest: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mytableview: UITableView!
    
    var name : [String] = ["Sandeep","Satya", "Hema","Rohit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.mytableview.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = name[indexPath.row]
        return cell
        
    }
   

}
