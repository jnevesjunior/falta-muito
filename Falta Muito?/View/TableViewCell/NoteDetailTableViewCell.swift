//
//  NoteDetailTableViewCell.swift
//  Falta Muito?
//
//  Created by Jose Neves on 04/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class NoteDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var noteSlider: LargeSlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
}
