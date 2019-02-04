//
//  RVExchangeRate.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 29/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

protocol ExchangeRateBaseProtocol {
    func getBaseRate(amount: Float) -> RVExchangeRate?
    func getRate(amount: Float, rate: (key: String, value: Float)) -> RVExchangeRate?
}

struct RVExchangeRate {
    
    let currencyOne: CurrencyType
    let currencyTwo: CurrencyType
    let rate: Float
    let amount: Float
    
    var exchange: Float {
        get {
            return 1 / self.rate
        }
    }
    
    var exchangeValue: Float {
        if self.currencyOne == currencyTwo {
            return self.amount
        }
        return NSDecimalNumber(value: self.exchange * self.amount).floatValue
    }
}
