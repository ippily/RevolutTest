//
//  LatestCurrencyViewModel.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 29/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

class LatestCurrencyViewModel: CurrencyTableViewCellModel {
    
    private let currencyType: CurrencyType?
    private let exchangeRate: RVExchangeRate
    
    init(exchangeRate: RVExchangeRate) {
        self.exchangeRate = exchangeRate
        self.currencyType = exchangeRate.currencyTwo
    }
    
    var currencyTitle: String? {
        return self.currencyType?.title
    }
    
    var abbreviation: String? {
        return self.currencyType?.rawValue
    }
    
    var currencyValue: String? {
        guard let value = RVNumberFormatter.currencyFormatter.string(from: NSDecimalNumber(value: self.exchangeRate.exchangeValue)),
            value != "0" else {
            return ""
        }
        return value
    }
}
