//
//  CurrencyListDatasource.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

class CurrencyListDatsource: RVBaseDatasourceProtocol {
    
    private let currency: CurrencyType
    private let completion: ((RequestResult)->())?
    
    init(currency: CurrencyType, completion: ((RequestResult)->())?) {
        self.currency = currency
        self.completion = completion
    }

    func requestData() {
        let request = CurrencyListRequest(currency: self.currency)
        request.makeRequest(completion: self.completion)
    }
}
