//
//  BudgTranTableViewCell.swift
//  Zeal
//
//  Created by Home-AX50 on 2015-11-30.
//  Copyright © 2015 Team 05. All rights reserved.
//

import UIKit

class BudgTranTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var budgTransNameLbl: UILabel!
    @IBOutlet weak var budgTransDateLbl: UILabel!
    @IBOutlet weak var budgTransPriceLbl: UILabel!
    @IBOutlet weak var budgTransPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
