//
//  RecordExpenses.swift
//  iOSBudgetManager
//
//  Created by Samavedam,Shravya on 7/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class RecordExpenses: NSObject {
    var category:String
    var left:Double
    var budgeted:Double
    var imageString:String
    
    init(category:String,imageString:String,left: Double,budgeted: Double, TransactionRecords : [Transactions]){
        self.category=category
        self.imageString=imageString
        self.left = left
        self.budgeted = budgeted
        self.TransactionRecords = TransactionRecords
        
            }
    var TransactionRecords : [Transactions]
    
    
}
