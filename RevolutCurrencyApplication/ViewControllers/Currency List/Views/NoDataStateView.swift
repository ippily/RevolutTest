//
//  NoDataStateView.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 03/02/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import UIKit

struct NoDataStateViewModel {
    var title: String
    var image: String
    
    static let noDataAvailable: NoDataStateViewModel = NoDataStateViewModel(
        title: "No data available, please try again.",
        image: "icon_delete_cloud"
    )
}

class NoDataStateView: RVNibView {
    
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var reloadButton: UIButton?
    
    private var reloadTapped: (() -> Void)?
    struct Style {
        var titleColor: UIColor
        var titleFont: UIFont?
        var imageTintColor: UIColor
        var buttonTintColor: UIColor
        
        static let defaultStyle: Style = Style(
            titleColor: .black,
            titleFont: UIFont(name: "ArialBold-MT", size: 14),
            imageTintColor: RVColors.primaryTitleColor,
            buttonTintColor: RVColors.primaryTitleColor
        )
    }
    
    private var style: Style = .defaultStyle {
        didSet {
            self.titleLabel?.textColor = self.style.titleColor
            self.titleLabel?.font = self.style.titleFont
            self.imageView?.tintColor = self.style.imageTintColor
            self.reloadButton?.tintColor = self.style.buttonTintColor
            self.reloadButton?.layer.borderColor = self.style.buttonTintColor.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.reloadButton?.layer.borderWidth = 1
        self.reloadButton?.setTitle("Click Here", for: .normal)
    }
    
    public func setup(_ model: NoDataStateViewModel,
                      style: Style = .defaultStyle,
                      reloadTapped: (() -> Void)?) {
        self.style = style
        self.titleLabel?.text = model.title
        self.imageView?.image = UIImage(named: model.image)
        self.reloadTapped = reloadTapped
    }
    
    @IBAction private func reloadButtonTapped(_ sender: Any) {
        self.reloadTapped?()
    }
}
