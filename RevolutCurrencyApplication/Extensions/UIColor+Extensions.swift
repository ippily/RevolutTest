//
//  UIColor+Extensions.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(red255: Int,
                            green255: Int,
                            blue255: Int,
                            alpha: CGFloat = 1.0) {
        assert(red255 >= 0 && red255 <= 255, "Invalid red component")
        assert(green255 >= 0 && green255 <= 255, "Invalid green component")
        assert(blue255 >= 0 && blue255 <= 255, "Invalid blue component")
        
        self.init(
            red: CGFloat(red255) / 255.0,
            green: CGFloat(green255) / 255.0,
            blue: CGFloat(blue255) / 255.0,
            alpha: alpha
        )
    }
    
    public convenience init(hex:Int, alpha: CGFloat = 1.0) {
        self.init(
            red255:(hex >> 16) & 0xff,
            green255:(hex >> 8) & 0xff,
            blue255:hex & 0xff,
            alpha: alpha
        )
    }
}
