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
    
    init(client: HTTPClient = HTTP()) {
        self.client = client
    }
    
    func getAllPopularMovies(completion: @escaping (Result<PopularMovies, APIError>) -> Void) {
        let apiDetails = APIRequest()
        let request = apiDetails.request(path: "movie/popular", method: HTTPMethod.get, page: "1")
        client.perform(request, completion)
    }
    
    func whatever() {
        getAllPopularMovies { (result) in
            switch result {
            case .success(let movies):
                print(movies)
            case .failure:
                print("erro")
            }
        }
    }
}

