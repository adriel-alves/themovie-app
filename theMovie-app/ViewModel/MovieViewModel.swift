//
//  MovieViewModel.swift
//  theMovie-app
//
//  Created by Adriel Alves on 26/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    var movie: Movie!
    var title: String {
        return movie.title
    }
    var genresIds: [Int] {
        return movie.genreIds
    }
    var overview: String {
        return movie.overview
    }
    var releaseDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        
        guard let release = movie.releaseDate else {
            return nil
        }
        
        return formatter.date(from: release)
    }
    var posterPath: URL? {
        return URL(string: "https://image.tmdb.org/t/p/\(movie.posterPath ?? "")")
    }
    
}
