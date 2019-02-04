//
//  RVRequestHandling.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 03/02/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

public enum RequestResult {
    case success(AnyObject)
    case failed(Error)
}

public enum ServiceErrors: Error {
    case failedRequest
    case parseError
}

