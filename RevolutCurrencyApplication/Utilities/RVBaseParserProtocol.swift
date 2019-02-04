//
//  RVBaseParserProtocol.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

public protocol RVBaseParserProtocol {
    func parseData(_ data: Data?) -> AnyObject?
}
