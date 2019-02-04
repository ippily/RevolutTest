//
//  CurrencyTableViewCell.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import UIKit

protocol CurrencyTableViewCellModel {
    var currencyTitle: String? { get }
    var abbreviation: String? { get }
    var currencyValue: String? { get }
}

@IBDesignable class CurrencyTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var abbreviationLabel: UILabel?
    @IBOutlet private weak var currencyTitleLabel: UILabel?
    @IBOutlet private weak var inputTextField: CurrencyInputTextField?
    
    // MARK: - Style
    
    struct Style {
        var backgroundColor: UIColor
        
        var abbreviationColor: UIColor
        var abbreviationFont: UIFont?
        
        var currencyTitleColor: UIColor
        var currencyTitleFont: UIFont?
        
        static let baseStyle: Style = Style(
            backgroundColor: .white,
            
            abbreviationColor: RVColors.primarySubtitleColor,
            abbreviationFont: UIFont(name: "Arial-BoldMT", size: 14),
            
            currencyTitleColor: RVColors.primaryTitleColor,
            currencyTitleFont: UIFont(name: "ArialMT ", size: 10)
        )
    }
    
    private var style: Style = .baseStyle {
        didSet {
            self.contentView.backgroundColor = self.style.backgroundColor
            
            self.abbreviationLabel?.textColor = self.style.abbreviationColor
            self.abbreviationLabel?.font = self.style.abbreviationFont
            
            self.currencyTitleLabel?.textColor = self.style.currencyTitleColor
            self.currencyTitleLabel?.font = self.style.currencyTitleFont
        }
    }
    
    // MARK: - Public
    
    public func setup(model: CurrencyTableViewCellModel,
                      style: Style = .baseStyle) {
        self.style = style
        
        self.currencyTitleLabel?.text = model.currencyTitle
        self.abbreviationLabel?.text = model.abbreviation
        self.inputTextField?.text = model.currencyValue 
    }
    
    public func setTextDelegate(_ delegate: UITextFieldDelegate?,
                                becomeResponder: Bool = false) {
        self.inputTextField?.delegate = delegate
        
        if becomeResponder {
            self.inputTextField?.isUserInteractionEnabled = true
            self.inputTextField?.becomeFirstResponder()
        } else {
            self.inputTextField?.isUserInteractionEnabled = false
        }
    }
}
