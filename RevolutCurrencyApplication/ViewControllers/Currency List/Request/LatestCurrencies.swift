//
//  LatestCurrencies.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

struct LatestCurrencies: Decodable {
    
    let base: String
    let date: String
    let rates: [String: Float]

    // MARK:
    // MARK: Init

    init(base: String, date: String, rates: [String: Float]) {
        self.base = base
        self.date = date
        self.rates = rates
    }
    
    func modelFor(exchangeRate: RVExchangeRate) -> LatestCurrencyViewModel {
        return LatestCurrencyViewModel(exchangeRate: exchangeRate)
    }
    
    func getExchangeRates(withAmount amount: Float) -> [RVExchangeRate]? {
        var exchangeRates = [RVExchangeRate]()
        
        if let baseRate = self.getBaseRate(amount: amount) {
            exchangeRates.append(baseRate)
        }
        
        for rate in self.rates {
            guard let exchangeRate = self.getRate(amount: amount, rate: rate) else {
                continue
            }
            exchangeRates.append(exchangeRate)
        }
        
        return exchangeRates
    }
}

extension LatestCurrencies: ExchangeRateBaseProtocol {
    
    func getBaseRate(amount: Float) -> RVExchangeRate? {
        guard let baseCurrency = CurrencyType(rawValue: self.base),
            !rates.isEmpty else {
                return nil
        }
        return RVExchangeRate(
            currencyOne: baseCurrency,
            currencyTwo: baseCurrency,
            rate: 0,
            amount: amount
        )
    }
    
    func getRate(amount: Float, rate: (key: String, value: Float)) -> RVExchangeRate? {
        guard let currencyToExchange = CurrencyType(rawValue: rate.key),
            let baseRate = CurrencyType(rawValue: self.base) else {
                return nil
        }
        return RVExchangeRate(
            currencyOne: baseRate,
            currencyTwo: currencyToExchange,
            rate: rate.value,
            amount: amount
        )
    }
}
