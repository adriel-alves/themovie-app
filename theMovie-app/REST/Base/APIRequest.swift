//
//  APIDetails.swift
//  theMovie-app
//
//  Created by Adriel Alves on 20/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

struct APIRequest {
    
    let basePath = "https://api.themoviedb.org/3"
    let apiKey = "a2c5a2ef4c5d857540b54d155dd1ae9c"
    
}

extension APIRequest {
    
    func request(path: String, method: HTTPMethod, page: String) -> URLRequest {
        var request: URLRequest
        guard let url = URL(string: basePath) else { fatalError("Bad resourceName: \(basePath)") }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let commonQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: page)
        ]
        
        components.queryItems = commonQueryItems
        components.path = path
        
        request = URLRequest(url: components.url!)
        request.httpMethod = method.toString()
        request.allHTTPHeaderFields = ["Content-type": "application/json"]
        
        return request
    }
    
}