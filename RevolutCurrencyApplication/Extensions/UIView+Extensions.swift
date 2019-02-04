//
//  UIView+Extensions.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 03/02/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Loads instance from nib with the same name.
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
