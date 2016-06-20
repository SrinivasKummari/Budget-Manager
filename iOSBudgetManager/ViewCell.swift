//
//  ViewCell.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 7/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {

    
    
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var left: UILabel!
    
    @IBOutlet weak var budget: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(Category : String, leftamount : String, budgetamount : String) {
        
        
        
        category.text = Category
        budget.text = budgetamount
        left.text = leftamount
        
    }
    

    
    
    
    
}
