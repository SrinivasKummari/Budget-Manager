//
//  Budgets.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Budgets: NSObject {
   
    var period : String
    var list : [RecordExpenses]
    
    init(timeFrame : String, records : [RecordExpenses] )
    {
     
        self.period = timeFrame
        self.list = records
        
    }
    
    
    
    
    
    
}
