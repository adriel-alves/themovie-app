//
//  MovieViewModel.swift
//  theMovie-app
//
//  Created by Adriel Alves on 26/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel {
   
    var movie: Movie!
    var title: String {
        return movie.title
    }
    
    var genreIds: [Int]  {
        return movie.genreIds
    }
    
    var overview: String {
        return movie.overview
    }
    
    var releaseDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        
        if let release = movie.releaseDate {
            return formatter.date(from: release)
        } else {
            return nil
        }
    }
    
    var year: String {
        
        if let releaseDate = releaseDate {
            let year = Calendar.current.component(Calendar.Component.year, from: releaseDate)
            return String(year)
        }
        return "----"
    }
    
    var posterPath: URL? {
        return URL(string: "https://image.tmdb.org/t/p/original\(movie.posterPath )")
    }
    
    var id: Int64 {
        return movie.id
    }

    var favorite: Bool {
        return favoriteButtonToggle()
    }
    
    var favoriteButtonImage: UIImage {
        return favorite ? UIImage(named: "favorite_full_icon")! : UIImage(named: "favorite_empty_icon")!
    }
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    func favoriteButtonToggle() -> Bool {
        let favoriteManager = FavoriteMoviesManager()
        favoriteManager.loadFavoriteMovies(index: id)
        return favoriteManager.favoriteMoviesData.count != 0
    }

}
