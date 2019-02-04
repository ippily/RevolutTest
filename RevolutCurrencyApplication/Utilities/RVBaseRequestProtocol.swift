//
//  RVBaseRequestProtocol.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import Foundation

public protocol RVBaseRequestProtocol {
    func urlRequest() -> URLRequest?
    func urlWithParameter() -> String
    
    func parameters() -> [String]
    func basePath() -> String
    func parser() -> RVBaseParserProtocol?
}

extension RVBaseRequestProtocol {
    
    public func urlRequest() -> URLRequest? {
        return URLRequest.baseRequest(path:self.urlWithParameter()) ?? nil
    }
    
    public func urlWithParameter() -> String {
        let parameters = self.parameters().count > 0
            ? "?" + self.parameters().compactMap({"\($0)"}).joined(separator: "&")
            : ""
        return self.basePath() + parameters
    }
    
    public func makeRequest(completion: ((RequestResult)->())?) {
        guard let request = self.urlRequest() else {
            completion?(RequestResult.failed(ServiceErrors.failedRequest))
            return
        }

        let task = RVURLSession.session.dataTask(with: request) {
            (data, response, error) in
            guard let data = data,
                let parser = self.parser(),
                let parsedData = parser.parseData(data) else {
                    
                DispatchQueue.main.async {
                    completion?(RequestResult.failed(ServiceErrors.parseError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion?(RequestResult.success(parsedData))
            }
        }
        task.resume()
    }
}
