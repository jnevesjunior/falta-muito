//
//  NoteTableViewCell.swift
//  Falta Muito?
//
//  Created by Jose Neves on 09/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var evaluationLabel: UILabel!
    @IBOutlet weak var maxNoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
