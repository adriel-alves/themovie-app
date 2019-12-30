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
    var movies: [MovieViewModel] = []
  
    init(theMovieService: TheMovieService = TheMovieServiceImpl()) {
        self.theMovieService = theMovieService
    }

    func requestMovies() {
        
        theMovieService.getMovies { (result) in
            switch result {
            case .failure(let error):
                print(APIError.taskError(error: error))
            case .success(let popularMovies):
                self.movies.append(contentsOf: popularMovies.results.map({ MovieViewModel($0) }))
        
            }
        }
    }
    
    
}
