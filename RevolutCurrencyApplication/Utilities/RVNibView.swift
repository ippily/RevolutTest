//
//  RVNibView.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 03/02/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import UIKit

class RVNibView: UIView {
    
    @IBOutlet private var subview: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadNibFile()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadNibFile()
    }
    
    private func loadNibFile() {
        self.subview = self.loadNib()
        
        guard let subview = self.subview else {
            return
        }
        subview.frame = bounds
        self.addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: subview, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: subview, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: subview, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: subview, attribute: .trailing, multiplier: 1.0, constant: 0.0))
    }
}

