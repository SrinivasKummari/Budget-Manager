//
//  TransactionCell.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(transactiontitle : String, Date : String, Tamount: Double)
    {
        title.text = transactiontitle
        date.text = Date
        amount.text = "$\(Tamount)"
        
        
    }
    

    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
