//
//  AppDelegate.swift
//  iOSBudgetManager
//
//  Created by Student on 6/29/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userEmail:String!
    var accountType:Int!
    var catSelected:String!
    var  recordExpenses=[RecordExpenses(category: "Food", imageString: "food.png", left: 150.0, budgeted:150.0,TransactionRecords : [Transactions(title: "Walmart", date: "07/11/15", Details: "Food", amount: 82.9),Transactions(title: "Walmart", date: "07/12/15", Details: "Food", amount: 67.9),Transactions(title: "Walmart", date: "07/13/15", Details: "Food", amount: 28.9)]),RecordExpenses(category: "Shopping", imageString: "shop.png", left:100.0, budgeted: 100.00, TransactionRecords : []),RecordExpenses(category: "Rent", imageString: "home.png", left: 150, budgeted: 150.00,TransactionRecords : []),RecordExpenses(category: "Fuel", imageString: "fuel.png", left: 50.0, budgeted: 50.0, TransactionRecords : []),RecordExpenses(category: "Others", imageString: "others.png", left: 200.0, budgeted:200.0,TransactionRecords : [])]
    var year : Int = 0
    var month : String = " "
    //var Category1 : [String] = ["Food", "Shopping", "Rent", "Fuel" , "Others", "Entertainment", "Internet", "Electicity", "Water", "Movies", "Health"]
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        //println(data)
        var jsonArray: NSArray = (NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSArray)!
        return jsonArray;
    }
    var monthName : String = ""
    var alterYear=0
    var alterMonth=0
    var Category1:NSArray = NSArray();
    var currentBudget:NSArray=NSArray();
    var amount : Double = 0.0
    var selectedRow=0
    var index : Int = 0 // create budget, modify budget
    //var budget : [Budgets] = [Budgets(timeFrame: "June 2015", records: [RecordExpenses(category: "Food", imageString: "food.png", left: -29.70, budgeted:150.0,TransactionRecords : [Transactions(title: "Walmart", date: "07/11/15", Details: "Food", amount: 82.9),Transactions(title: "Walmart", date: "07/12/15", Details: "Food", amount: 67.9),Transactions(title: "Walmart", date: "07/13/15", Details: "Food", amount: 28.9)]),RecordExpenses(category: "Shopping", imageString: "shop.png", left:100.0, budgeted: 100.00, TransactionRecords : []),RecordExpenses(category: "Rent", imageString: "home.png", left: 150, budgeted: 150.00,TransactionRecords : []),RecordExpenses(category: "Fuel", imageString: "fuel.png", left: 50.0, budgeted: 50.0, TransactionRecords : []),RecordExpenses(category: "Others", imageString: "others.png", left: 200.0, budgeted:200.0,TransactionRecords : [])]), Budgets(timeFrame: "July 2015", records: [RecordExpenses(category: "Food", imageString: "food.png", left: 20.30, budgeted:200.0,TransactionRecords : [Transactions(title: "Walmart", date: "07/11/15", Details: "Food", amount: 82.9),Transactions(title: "Walmart", date: "07/12/15", Details: "Food", amount: 67.9),Transactions(title: "Walmart", date: "07/13/15", Details: "Food", amount: 28.9)]),RecordExpenses(category: "Shopping", imageString: "shop.png", left:100.0, budgeted: 100.00, TransactionRecords : []),RecordExpenses(category: "Rent", imageString: "home.png", left: 175, budgeted: 175.00,TransactionRecords : []),RecordExpenses(category: "Fuel", imageString: "fuel.png", left: 50.0, budgeted: 50.0, TransactionRecords : []),RecordExpenses(category: "Others", imageString: "others.png", left: 100.0, budgeted:100.0,TransactionRecords : [])]),Budgets(timeFrame: "September 2015", records: [RecordExpenses(category: "Food", imageString: "food.png", left: 200.00, budgeted:200.0,TransactionRecords : []),RecordExpenses(category: "Shopping", imageString: "shop.png", left:150.0, budgeted: 150.00, TransactionRecords : []),RecordExpenses(category: "Rent", imageString: "home.png", left: 250, budgeted: 250.00,TransactionRecords : []),RecordExpenses(category: "Fuel", imageString: "fuel.png", left: 50.0, budgeted: 50.0, TransactionRecords : []),RecordExpenses(category: "Others", imageString: "others.png", left: 100.0, budgeted:100.0,TransactionRecords : [])]), Budgets(timeFrame: "October 2015", records: [RecordExpenses(category: "Food", imageString: "food.png", left: 250.00, budgeted:250.0,TransactionRecords : []),RecordExpenses(category: "Shopping", imageString: "shop.png", left:125.0, budgeted: 125.00, TransactionRecords : []),RecordExpenses(category: "Rent", imageString: "home.png", left: 300, budgeted: 300,TransactionRecords : []),RecordExpenses(category: "Fuel", imageString: "fuel.png", left: 100.0, budgeted: 100.0, TransactionRecords : []),RecordExpenses(category: "Others", imageString: "others.png", left: 150.0, budgeted:150.0,TransactionRecords : [])])]
    var budget:[Budgets]=[]
    var timeFrame : String = ""
    var selectedTimeFrame : String = ""
    var budgetIndex :Int = 0
    var transactionIndex : Int = 0
    var timeFrameAlter : String = ""
    var budgetCopy : [RecordExpenses] = [RecordExpenses(category: "Shopping", imageString: "shop.png", left:100.0, budgeted: 100.00, TransactionRecords : []),RecordExpenses(category: "Rent", imageString: "home.png", left: 150, budgeted: 150.00,TransactionRecords : [])]
    var reportSelection : String = ""
    var budgetIndexAlter :Int = 0
    var indexAlter : Int = 0
    var selectedYear : Int = 0
    var selectedMonth : Int = 0
    var tmonth : NSString = ""
    var tyear : NSString = ""
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "nwmsu.com.iOSBudgetManager" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("iOSBudgetManager", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("iOSBudgetManager.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    var budgets=NSArray()
    func loadData(){
        
        
        // budget.removeAll(keepCapacity: true)
        
         budgets = dataOfJson("http://198.209.246.96/budgetmanager/getAllBudgets.php?email=\(userEmail)&accountType=\(accountType)");
        
        
        
        println("\n count of budgets of this user--- \(budgets.count)")
        println("cats in bud 2 is::\(budgets[1].count)")
        var catar:[AnyObject]=(budgets[1].valueForKey("categories") as? Array)!
        println("catar size: \(catar.count)")
        var budgetarr :[Budgets] = []
        var categoryarr : [RecordExpenses] = []
        for(var i = 0; i < budgets.count; i++){
            var timeframe = budgets[i].valueForKey("timeframe") as? String
            var catarray :[AnyObject] = (budgets[i].valueForKey("categories") as? Array)!
            
            for(var j=0;j<catarray.count;j++){
                var category =  catarray[j].valueForKey("catName") as? String
                var imageString = catarray[j].valueForKey("icon") as? String
                var leftString = catarray[j].valueForKey("amountSpent") as? String
                println("amountspent--\(leftString)")
                var left : Double = (leftString! as NSString).doubleValue
                var budgetedstr = catarray[j].valueForKey("amountAlotted") as? String
                var budgeted : Double = (budgetedstr! as NSString).doubleValue
                
                println("\(category) \(imageString) \(left) \(budgeted) \(timeframe)")
                if(imageString == nil)
                {
                    imageString = ""
                }
                
                categoryarr.append(RecordExpenses(category: category! , imageString: imageString!, left:left, budgeted:budgeted,TransactionRecords :[]))
            }
            
            var time = split(timeframe!){$0 == " "}
            var mnth = getMonthAsString(time[0])
            var year = time[1]
            
            budgetarr.append(Budgets(timeFrame:"\(mnth) \(year)", records: categoryarr))
            println("count of categories for budget at location 0 is \(budgetarr.count)")
            categoryarr.removeAll(keepCapacity: true)
        }
        
        budget.removeAll(keepCapacity: true)
        
        budget = budgetarr
        
    }
    
    
    func getMonthAsString( mnthnum:String)-> String{
        
        var month = ""
        
        var mnths = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October","November", "December"]
        
        if(mnthnum=="1"){
            month = mnths[0]
        }else if(mnthnum=="2"){
            month = mnths[1]
            
        }else if(mnthnum=="3"){
            month = mnths[2]
        }
        else if(mnthnum=="4"){
            month = mnths[3]
        }
        else if(mnthnum=="5"){
            month = mnths[4]
        }
        else if(mnthnum=="6"){
            month = mnths[5]
        }
        else if(mnthnum=="7"){
            month = mnths[6]
        }
        else if(mnthnum=="8"){
            month = mnths[7]
        }
        else if(mnthnum=="9"){
            month = mnths[8]
        }
        else if(mnthnum=="10"){
            month = mnths[9]
        }
        else if(mnthnum=="11"){
            month = mnths[10]
        }
        else if(mnthnum=="12"){
            month = mnths[11]
        }
        
        
        return month
    }
    

}

