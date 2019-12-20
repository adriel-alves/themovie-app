//
//  TheMovieAPI.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

final class TheMovieAPI: HTTPClient, TheMovieService {
   
    let session: URLSession
    var basePath = "https://api.themoviedb.org/3"
    let apiKey = "a2c5a2ef4c5d857540b54d155dd1ae9c"
    
     init(configuration: URLSessionConfiguration) {
           self.session = URLSession(configuration: configuration)
       }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getAllPopularMovies(completion: @escaping (Result<PopularMovies?, APIError>) -> Void) {
        guard let url = URL(string: basePath) else { fatalError("Bad resourceName: \(basePath)") }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let commonQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
        ]
        
        components.queryItems = commonQueryItems
        
        let request = URLRequest(url: components.url!)
        
        
        self.perform(request, decode: { (json) -> PopularMovies? in
            guard let result = json as? PopularMovies else {
                return nil
            }
            return result
        }, completion: completion)
    }
    
    
    
    
    
}

