//
//  LargeSlider.swift
//  Falta Muito?
//
//  Created by Jose Neves on 18/06/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

@IBDesignable class LargeSlider: UISlider {
    
    @IBInspectable var sliderHeight: CGFloat = 30
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: self.sliderHeight))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    func isWarningMode(isWarningMode: Bool) {
        if (isWarningMode) {
            self.minimumTrackTintColor = UIColor.red
        } else {
            self.minimumTrackTintColor = UIColor(red: 1.0, green: 0.75, blue: 0.27, alpha: 1.0)
        }
    }
}
