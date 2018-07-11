//
//  NoteDetailTableViewCell.swift
//  Falta Muito?
//
//  Created by Jose Neves on 04/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit
import fluid_slider

class NoteDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var slider: Slider!
    
    private var maxValue: CGFloat = 10
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        self.slider.setMinimumImage(UIImage(named: "baseline_mood_bad_black_24pt"))
        self.slider.setMaximumImage(UIImage(named: "baseline_mood_black_24pt"))
        self.slider.imagesColor = .white
        self.slider.setMinimumLabelAttributedText(NSAttributedString(string: ""))
        self.slider.setMaximumLabelAttributedText(NSAttributedString(string: ""))
        self.slider.contentViewColor = UIColor(red: 1.0, green: 0.75, blue: 0.27, alpha: 1.0)
        self.slider.valueViewColor = .white
        self.slider.didEndTracking = { (slider) in
            slider.fraction = round(slider.fraction * 1000.0) / 1000.0
        }
    }
    
    func setSliderValue(value: CGFloat) {
        self.slider.fraction = value / self.maxValue
    }
    
    func setMaxSliderValue(maxValue: CGFloat) {
        self.maxValue = maxValue
        var fontSize: CGFloat = 12
        
        if (maxValue > 10) {
            fontSize = 11
        }
        
        self.slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 2
            let string = formatter.string(from: (fraction * maxValue) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .medium)])
        }
    }
    
    func isWarningMode(isWarningMode: Bool) {
        if (isWarningMode) {
            self.slider.contentViewColor = UIColor.red
        }
        else {
            self.slider.contentViewColor = UIColor(red: 1.0, green: 0.75, blue: 0.27, alpha: 1.0)
        }
    }
}
