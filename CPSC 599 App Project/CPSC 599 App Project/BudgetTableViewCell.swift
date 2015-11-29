//
//  BudgetTableViewCell.swift
//  Budget Balancer
//
//  Created by Home-AX50 on 2015-11-04.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var budgetNameLbl: UILabel!
    @IBOutlet weak var budgetAmtLbl: UILabel!
    @IBOutlet weak var budgetProgBar: UIProgressView!
    @IBOutlet weak var budgetPic: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
