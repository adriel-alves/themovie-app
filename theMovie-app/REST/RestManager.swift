//
//  RestManager.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

class RestManager {
    
    var requestHttpHeaders = RestEntity()

    var urlQueryParameters = RestEntity()

    var httpBodyParameters = RestEntity()
    
private func addUrlQueryParameters(toURL url:URL) -> URL {
    
    var queryItems = [URLQueryItem]()
   
    if urlQueryParameters.totalItems() > 0 {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return url }
        
        for (key, value) in urlQueryParameters.allValues() {
          let item = URLQueryItem(name: key, value: value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))

          queryItems.append(item)
        }

    }
 
    return url
}
    
}

extension RestManager {
    
struct Response {
    var response: URLResponse?
    var httpStatusCode: Int = 0
    var headers = RestEntity()
    
    init(fromURLResponse response: URLResponse?) {
           guard let response = response else { return }
           self.response = response
           httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
    
           if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
               for (key, value) in headerFields {
                   headers.add(value: "\(value)", forKey: "\(key)")
               }
           }
       }
}
    
struct RestEntity {
    private var values: [String: String] = [:]
 
    mutating func add(value: String, forKey key: String) {
        values[key] = value
    }
 
    func value(forKey key: String) -> String? {
        return values[key]
    }
 
    func allValues() -> [String: String] {
        return values
    }
 
    func totalItems() -> Int {
        return values.count
    }
}
    
struct Results {
    var data: Data?
    var response: Response?
    var error: Error?
    
    init(withData data: Data?, response: Response?, error: Error?) {
           self.data = data
           self.response = response
           self.error = error
       }
    
       init(withError error: Error) {
           self.error = error
       }
}
  
}


