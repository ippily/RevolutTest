//
//  RVBaseDatasourceProtocol.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 26/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

public protocol RVBaseDatasourceProtocol {
    func requestData()
}

extension RVBaseDatasourceProtocol {
    
    /// Triggers initial loading
    public func load() {
        self.requestData()
    }
}
