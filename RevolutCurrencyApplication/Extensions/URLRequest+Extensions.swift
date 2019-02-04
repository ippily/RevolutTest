//
//  URLRequest+Extensions.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    private func defaultHeaders() -> Dictionary <String,String> {
        return ["Accept":"application/json",
                "Content-Type":"application/x-www-form-urlencoded; charset=utf-8",
        ]
    }
    
    static func baseRequest(path: String) -> URLRequest? {
        return self.requestWithEndpoint(path:"\(RVBaseURL.path)\(path)") ?? nil
    }
    
    public static func requestWithEndpoint(path: String,
                                           httpMethod: String? = "GET",
                                           requestBody: Data? = nil) -> URLRequest? {
        
        guard let url = URL(string:path) else {
            assertionFailure("")
            return nil
        }
        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 8.0
        )
        
        request.allHTTPHeaderFields = request.defaultHeaders()
        request.httpMethod = httpMethod
        request.httpBody = requestBody
        return request
    }
}
