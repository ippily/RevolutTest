//
//  CurrencyInputTextField.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 26/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import UIKit

@IBDesignable class CurrencyInputTextField: UITextField {
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textAlignment = .center
        self.borderStyle = .none
        self.keyboardType = .decimalPad
        
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(self.dismissKeyboard)
        )
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addBottomBorder()
    }
    
    private func addBottomBorder() {
        let border = CALayer()
        let width: CGFloat = 0.5
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(
            x: 0,
            y: self.frame.size.height - width,
            width: self.frame.size.width,
            height: self.frame.size.height
        )
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    @objc func dismissKeyboard() {
        self.resignFirstResponder()
    }
}
