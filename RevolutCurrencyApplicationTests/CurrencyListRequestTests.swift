//
//  CurrencyListRequestTests.swift
//  RevolutCurrencyApplicationTests
//
//  Created by Emily Ip on 29/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import XCTest
@testable import RevolutCurrencyApplication

class CurrencyListRequestTests: XCTestCase {

    func testCreate() {
        let request = CurrencyListRequest(currency: .EUR)
        XCTAssertEqual(request.basePath(), "/latest")
        XCTAssertEqual(request.parameters().joined(), "base=EUR")
        XCTAssertEqual(request.urlWithParameter(), "/latest?base=EUR")
        
        let baseRequestURL = URLRequest.baseRequest(path: request.urlWithParameter())!.url?.absoluteString
        XCTAssertEqual(baseRequestURL, "\(RVBaseURL.path)/latest?base=EUR")
        
        request.makeRequest { (result) in
            switch result {
            case .failed(_):
                XCTFail()
            case .success(let currencies):
                let latestCurrencies = currencies as! LatestCurrencies
                let rates = latestCurrencies.rates
                
                XCTAssertEqual(rates.count, 32,
                               "The number of rates should return 32")
                XCTAssertEqual(latestCurrencies.base, "EUR",
                               "Base value is incorrect")
                
            }
        }
    }
    
    func testDatasource() {
        let datasource = CurrencyListDatsource(currency: .CAD) { (result) in
            switch result {
            case .failed(_):
                XCTFail()
            case .success(let currencies):
                let latestCurrencies = currencies as! LatestCurrencies
                let rates = latestCurrencies.rates
                XCTAssertEqual(rates.count, 32,
                               "The number of rates should return 32")
                XCTAssertEqual(latestCurrencies.base, "CAD",
                               "Base value is incorrect")

                XCTAssertEqual(rates.first!.key, "AUD")
            }
        }

        datasource.load()
    }
}
