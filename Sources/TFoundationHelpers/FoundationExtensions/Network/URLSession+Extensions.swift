//
//  URLSession+Extensions.swift
//  
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension URLSession {
    public func synchronousDataTask(urlRequest: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: urlRequest) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
    
    public func synchronousDownloadTask(urlRequest: URLRequest) -> (url: URL?, response: URLResponse?, error: Error?) {
        var url: URL?
        var response: URLResponse?
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)
        let task = self.downloadTask(with: urlRequest) {
            url = $0
            response = $1
            error = $2
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return (url, response, error)
    }
}

extension URLRequest {
    /// Curl String
    public var curlString: String {
        var result = "curl -k "
        
        if let method = httpMethod {
            result += "-X \(method) \\\n"
        }
        
        if let headers = allHTTPHeaderFields {
            for (header, value) in headers {
                result += "-H \"\(header): \(value)\" \\\n"
            }
        }
        
        if let body = httpBody, !body.isEmpty, let string = String(data: body, encoding: .utf8), !string.isEmpty {
            result += "-d '\(string)' \\\n"
        }
        
        if let url = url {
            result += url.absoluteString
        }
        
        return result
    }
}
