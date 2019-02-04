//
//  CurrencyListRequest.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

struct CurrencyListRequest: RVBaseRequestProtocol {
    
    private let currency: CurrencyType
    
    init(currency: CurrencyType) {
        self.currency = currency
    }
    
    func basePath() -> String {
        return "/latest"
    }
    
    func parameters() -> [String] {
        return ["base=\(self.currency.rawValue)"]
    }
    
    func parser() -> RVBaseParserProtocol? {
        return CurrencyListParser()
    }
}
