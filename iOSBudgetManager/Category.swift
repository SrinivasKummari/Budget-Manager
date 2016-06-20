//
//  Category.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/8/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Category: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    
    @IBOutlet weak var categoryList: UITableView!
    
    //var Category1 : [String] = ["Food", "Shopping", "Rent", "Fuel" , "Others"]
    
   // @IBOutlet weak var CatName: UILabel!
    var catName:UILabel!
    var catImage:UIImageView!
    //@IBOutlet weak var catImage: UIImageView!
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                //share.Category1=Category1  [String]
//   UINavigationBar.appearance().barTintColor = UIColor(red: 10/255.5, green: 50/255.5, blue: 50/255.5, alpha: 1)
        
  self.navigationItem.title = "Categories"
        //share.Category1.sort(){$0 < $1}
            }

//    @IBOutlet weak var image: UIImageView!
//    let logo = UIImage(named: "imgres.png")
//    let imageView = UIImageView(image:logo)
//    self.navigationItem.titleView = imageView
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

       func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return share.Category1.count
    }
    
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var imgString:String
    
    var cell : CustomCell = categoryList.dequeueReusableCellWithIdentifier("cell") as! CustomCell
    //cell.textLabel?.text = share.Category1[indexPath.row]["CATEGORY_NAME"] as? String
    var catNM=share.Category1[indexPath.row]["CATEGORY_NAME"] as! String
    println("cat name: \(catNM)")
    
    cell.catName.text=catNM.capitalizedString
    
    //var imgString=share.Category1[indexPath.row]["ICON"] as! String
    if(share.Category1[indexPath.row]["ICON"] as? String != nil){
        
        
        imgString=share.Category1[indexPath.row]["ICON"] as! String
        println("imagestring is \(imgString)")
    }else{
        println("in image setting else condition")
        imgString="others.png";
    }
    
    println("image string:\(imgString)")
    cell.catImage.image=UIImage(named: imgString);
        //imageView.image = UIImage(named: imgString);
    cell.textLabel?.textColor=UIColor(red: 65/255, green: 147/255, blue: 132/255, alpha: 1)
//   cell.imageView?.image = UIImage(named: share.Category1[indexPath.row].
      return cell

    
    }
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController!.navigationBar.barTintColor = UIColor(red: 169/255, green: 214/255, blue: 201/255, alpha: 1)
        var Category1 : NSArray = dataOfJson("http://198.209.246.96/budgetmanager/categories.php?email=\(share.userEmail)&accountType=\(share.accountType)");
        share.Category1=Category1

        //share.Category1.sort(){$0 < $1}
        categoryList.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "add")
        {
            var creationPage : CategoryCreation = segue.destinationViewController as! CategoryCreation
            
            creationPage.id = self
            
            
            
            
            
        }
        
    }
    
    
    func save(name : String )
    {
        var catCount=0
        for(var i=0;i<share.Category1.count;i++){
            var catName=share.Category1[i]["CATEGORY_NAME"] as! String
            
            if(name.capitalizedString == catName.capitalizedString){
                
                var alert = UIAlertView(title: "Existing Category", message: "Please enter the new category name.", delegate: nil, cancelButtonTitle: "ok")
                alert.show()
            }else{
                catCount=catCount+1
            }
        }
        if(catCount == share.Category1.count){
        //share.Category1 += [name]
        var url: NSString = "http://198.209.246.96/budgetmanager/insertCategory.php?categoryName=\(name)&email=\(share.userEmail)&accountType=\(share.accountType)"
        println("insert cat url :\(url)")
        url = url.stringByReplacingOccurrencesOfString(" ", withString: "%20")
        url = url.stringByReplacingOccurrencesOfString("/n", withString: "%0A")
        var data = NSData(contentsOfURL: NSURL(string: url as String)!)
        var result = NSString(data: data!, encoding: NSUTF8StringEncoding)
        }
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func exit()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.Delete {
//            share.Category1.removeAtIndex(indexPath.row)["CATEGORY_NAME"] as? String
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//        }
//    }
    

   }
