//
//  PeriodTableViewCell.swift
//  Falta Muito?
//
//  Created by Jose Neves on 24/01/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class PeriodTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.selectionStyle = .none
    }
}
