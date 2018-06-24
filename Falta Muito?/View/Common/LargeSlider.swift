//
//  LargeSlider.swift
//  Falta Muito?
//
//  Created by Jose Neves on 18/06/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

@IBDesignable class LargeSlider: UISlider {
    
    @IBInspectable var sliderHeight: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.sliderHeight / 2
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let size = CGSize(width: bounds.size.width, height: self.sliderHeight)

        return CGRect(origin: bounds.origin, size: size)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    
    func isWarningMode(isWarningMode: Bool) {
        if (isWarningMode) {
            self.minimumTrackTintColor = UIColor.red
        } else {
            self.minimumTrackTintColor = UIColor(red: 1.0, green: 0.75, blue: 0.27, alpha: 1.0)
        }
    }
}
