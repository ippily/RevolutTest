//
//  LatestCurrenciesViewModelTests.swift
//  RevolutCurrencyApplicationTests
//
//  Created by Emily Ip on 29/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import XCTest
@testable import RevolutCurrencyApplication

class LatestCurrenciesViewModelTests: XCTestCase {

    func getMockLatestCurrencies() -> LatestCurrencies {
        let latestCurrencies: [String: Any] = [
            "base": "EUR",
            "date": "2018-09-06",
            "rates": [
                "AUD": 1.613,
                "BGN": 1.9517,
                "BRL": 4.7817,
                "CAD": 1.5306,
                "CHF": 1.1251,
                "CNY": 7.9283,
                "CZK": 25.661,
                "DKK": 7.441,
                "GBP": 0.89634,
                "HKD": 9.1131,
                "HRK": 7.4184,
                "HUF": 325.8
            ]
        ]
        
        let data = try! JSONSerialization.data(withJSONObject: latestCurrencies, options: .prettyPrinted)
        return try! JSONDecoder().decode(LatestCurrencies.self, from: data)
    }
    
    func testJsonData() {
        let latestCurrencies = self.getMockLatestCurrencies()
        let rate = latestCurrencies.rates.first(where: { $0.key == "HKD" })!
        
        XCTAssertEqual(latestCurrencies.base, "EUR")
        XCTAssertEqual(latestCurrencies.date, "2018-09-06")
        XCTAssertEqual(rate.key, "HKD")
        XCTAssertEqual(rate.value, 9.1131)
    }
    
    func testLatestCurrenciesModel() {
        let latestCurrencies = self.getMockLatestCurrencies()
        let rate = latestCurrencies.rates.first(where: { $0.key == "GBP" })!
        
        let exchangeRate = RVExchangeRate(
            currencyOne: .EUR,
            currencyTwo: CurrencyType(rawValue: rate.key)!,
            rate: rate.value,
            amount: 100
        )
        let model = latestCurrencies.modelFor(exchangeRate: exchangeRate)
        
        XCTAssertEqual(model.abbreviation, "GBP")
        XCTAssertEqual(model.currencyTitle, "British Pound")
        XCTAssertEqual(model.currencyValue, "111.565")
        
        let exchangeRateFromMethod = latestCurrencies.getExchangeRates(withAmount: 100)
        XCTAssertEqual(exchangeRateFromMethod?.count, 13)
    }
    
    func testExchangeRateProtocol() {
        let latestCurrencies = self.getMockLatestCurrencies()
        
        let baseRate = latestCurrencies.getBaseRate(amount: 100)!
        XCTAssertEqual(baseRate.currencyOne, .EUR)
        XCTAssertEqual(baseRate.currencyTwo, .EUR)
        XCTAssertEqual(baseRate.currencyOne, baseRate.currencyTwo,
                       "base rate currency one and two are both equal to indicate that it is the base rate")
        XCTAssertEqual(baseRate.exchangeValue, baseRate.amount,
                       "the amount should equal the exchange value for the base rate")
        
        let rateToExchange = latestCurrencies.rates.first(where: { $0.key == "GBP" })!
        let rate = latestCurrencies.getRate(amount: 100, rate: rateToExchange)!
        
        XCTAssertEqual(rate.currencyOne, .EUR)
        XCTAssertEqual(rate.currencyTwo, CurrencyType(rawValue: rateToExchange.key)!)
        XCTAssertNotEqual(rate.currencyOne, rate.currencyTwo,
                          "The first rate should be the base rate and the second should be the rate to exchange")
        XCTAssertEqual(rate.amount, 100)
        XCTAssertEqual(rate.exchange, 1.115648)
        XCTAssertEqual(rate.exchangeValue, 111.564804)
        XCTAssertEqual(rate.rate, 0.89634)
    }
}
