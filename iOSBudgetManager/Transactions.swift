//
//  Transactions.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Transactions: NSObject {
 
    var title : String
    var date : String
    var Details : String
    var amount : Double
    
    init( title : String, date : String , Details : String , amount : Double)
    {
        
        self.title = title
        self.date = date
        self.Details = Details
        self.amount = amount
    }
    
    
}
