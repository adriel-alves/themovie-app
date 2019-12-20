//
//  TheMovieServiceImpl.swift
//  theMovie-app
//
//  Created by Adriel Alves on 18/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

final class TheMovieServiceImpl: TheMovieService {
    
    let theMovieAPI: TheMovieAPI
    
    init(theMovieAPI: TheMovieAPI) {
        self.theMovieAPI = theMovieAPI
    }
    
    func getAllPopularMovies(completion: @escaping (Result<PopularMovies?, APIError>) -> Void) {
        return self.theMovieAPI.getAllPopularMovies(completion: completion)
    }
    
    
}
