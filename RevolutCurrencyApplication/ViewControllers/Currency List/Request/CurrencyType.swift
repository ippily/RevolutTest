//
//  CurrencyType.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

public enum CurrencyType: String, CaseIterable {
    
    case AUD,
    BGN,
    BRL,
    CAD,
    CHF,
    CNY,
    CZK,
    DKK,
    EUR,
    GBP,
    HKD,
    HRK,
    HUF,
    IDR,
    ILS,
    INR,
    ISK,
    JPY,
    KRW,
    MXN,
    MYR,
    NOK,
    NZD,
    PHP,
    PLN,
    RON,
    RUB,
    SEK,
    SGD,
    THB,
    TRY,
    USD,
    ZAR
    
    var title: String {
        switch self {
        case .AUD: return "Australian Dollar"
        case .CAD: return "Canadian Dollar"
        case .DKK: return "Danish Krone"
        case .EUR: return "Euro"
        case .GBP: return "British Pound"
        case .HKD: return "Hong Kong Dollar"
        case .USD: return "US Dollar"
        default: return ""
        }
    }
}
