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
    @IBOutlet weak var noteProgressView: UIProgressView!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.noteProgressView.layer.cornerRadius = 15
    }
    
    func isWarningMode(isWarningMode: Bool) {
        if (isWarningMode) {
            self.noteProgressView.progressTintColor = UIColor.red
        } else {
            self.noteProgressView.progressTintColor = UIColor(red: 1.0, green: 0.75, blue: 0.27, alpha: 1.0)
        }
    }
}
