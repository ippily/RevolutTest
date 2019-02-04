//
//  RVNumberFormatter.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 29/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

class RVNumberFormatter {
    
    public static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
