//
//  CurrencyListParser.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation
import UIKit

class CurrencyListParser: RVBaseParserProtocol {
    
    func parseData(_ data: Data?) -> AnyObject? {
        guard let data = data else {
            return nil
        }
        
        do {
            let latestCurrency = try JSONDecoder().decode(LatestCurrencies.self, from: data)
            return latestCurrency as AnyObject
        }
        catch {
            return nil
        }
    }
}
