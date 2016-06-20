//
//  CustomCell.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 10/29/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
