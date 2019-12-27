//
//  PopularMoviesViewModel.swift
//  theMovie-app
//
//  Created by Adriel Alves on 26/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

class PopularMoviesViewModel {
    
    var theMovieService: TheMovieService
    var popularMovies: PopularMovies!
    
    var movies: [Movie] = []
  
    init(theMovieService: TheMovieService = TheMovieServiceImpl()) {
        self.theMovieService = theMovieService
    }

    func requestMovies() {
        
        theMovieService.getMovies { (result) in
            switch result {
            case .failure(let error):
                print(APIError.taskError(error: error))
            case .success(let popularMovies):
                self.popularMovies = popularMovies
                self.movies = popularMovies.results
            }
        }
    }
    
    
}
