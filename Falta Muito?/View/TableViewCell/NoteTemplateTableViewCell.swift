//
//  NoteTemplateTableViewCell.swift
//  Falta Muito?
//
//  Created by Jose Neves on 10/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class NoteTemplateTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
