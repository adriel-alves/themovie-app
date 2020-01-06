//
//  TheMovieAPI.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

final class TheMovieServiceImpl: TheMovieService {
   
    let client: HTTPClient
    let apiDetails = APIRequest()
    init(client: HTTPClient = HTTP()) {
        self.client = client
    }
    
    func getMovies(page: Int = 1, completion: @escaping (Result<PopularMovies, APIError>) -> Void) {
        
        let queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        let request = apiDetails.request(path: "movie/popular", method: HTTPMethod.get, queryItems: queryItems)
        client.perform(request, completion)
    }
    
    func getGenresList(completion: @escaping (Result<Genre, APIError>) -> Void) {
        let request = apiDetails.request(path: "genre/movie/list", method: HTTPMethod.get)
        client.perform(request, completion)
       }
    
}

