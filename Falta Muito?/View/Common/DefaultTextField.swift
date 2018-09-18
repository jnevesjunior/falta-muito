//
//  DefaultTextField.swift
//  Falta Muito?
//
//  Created by Jose Neves on 12/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

@IBDesignable class DefaultTextField: UITextField {
    
    var beforeEditLineColor: UIColor = UIColor.white
    var beforeErrorLineColor: UIColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        limitCharacters()
        addTarget(self, action: #selector(self.limitCharacters), for: .editingChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setLine()
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.clear {
        didSet {
            self.setLine()
        }
    }
    
    @IBInspectable var editLineColor: UIColor = UIColor.black {
        didSet {
            self.beforeEditLineColor = self.lineColor
            self.setLine()
        }
    }
    
    @IBInspectable var errorLineColor: UIColor = UIColor.red {
        didSet {
            self.setLine()
        }
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            self.updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    func editMode(modeOn: Bool) {
        if (modeOn) {
            self.beforeEditLineColor = self.lineColor
            self.lineColor = self.editLineColor
        } else {
            self.lineColor = self.beforeEditLineColor
        }
        self.setLine()
    }
    
    @IBInspectable var maximumCharacters: Int = 50 {
        didSet {
            limitCharacters()
        }
    }
    
    @objc func limitCharacters() {
        guard text != nil else {
            return
        }
        if (text?.count)! > maximumCharacters {
            if let range = text?.index(before: (text?.endIndex)!) {
                text = String(text![..<range])
            }
        }
    }
    
    func errorMode(modeOn: Bool) {
        if (modeOn) {
            self.beforeErrorLineColor = self.lineColor
            self.lineColor = self.errorLineColor
        } else {
            self.lineColor = self.beforeErrorLineColor
        }
        self.setLine()
    }
    
    func setLineColor(color: UIColor) {
        self.lineColor = color
        self.setLine()
    }
    
    func setLine() {
        let border = CALayer()
        let width = CGFloat(2.0)
        
        border.borderColor = self.lineColor.cgColor
        border.borderWidth = width
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        
        for sublayer in layer.sublayers! {
            sublayer.borderWidth = 0
        }
        
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            
            let size = self.frame.height
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size/1.5, height: size/1.5))
            imageView.image = image
            
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        let placeholderColor = UIColor(white: 0/255, alpha: 0.25)
        let placeholderText = placeholder != nil ?  placeholder! : ""
        
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
}
