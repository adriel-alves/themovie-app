//
//  FavoriteMovieManagerMock.swift
//  theMovie-appTests
//
//  Created by Adriel Alves on 16/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@testable import theMovie_app

class FavoriteMovieManagerMock: FavoriteMoviesManagerProtocol {
   
    var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func buildFavoriteMovieData() -> [FavoriteMovieData] {
        
        var favoriteMovies: [FavoriteMovieData] = []
        var favoriteMovieData: FavoriteMovieData!
        
        favoriteMovieData = FavoriteMovieData(context: managedObjectContext)
        favoriteMovieData.movieTitle = "Captain Marvel"
        favoriteMovieData.movieYear = "0000"
        favoriteMovieData.movieDetails = "Voa e solta raio"
        favoriteMovieData.moviePoster = UIImage(named: "images")
        favoriteMovieData.id = 123
        
        var favoriteMovieData2: FavoriteMovieData!
        favoriteMovieData2 = FavoriteMovieData(context: managedObjectContext)
        favoriteMovieData2.movieTitle = "Iron Man"
        favoriteMovieData2.movieYear = "1000"
        favoriteMovieData2.movieDetails = "Genio bilionario playboy filantropo"
        favoriteMovieData2.moviePoster = UIImage(named: "images")
        favoriteMovieData2.id = 123
        
        favoriteMovies.append(contentsOf: [favoriteMovieData, favoriteMovieData2])
        
        return favoriteMovies
    }
    
    func fetch(filtering: String = "") -> [FavoriteMovieData]? { return buildFavoriteMovieData() }
    
    func fetchById(index: Int64) -> [FavoriteMovieData]? { return buildFavoriteMovieData() }
    
    func addFavoriteMovie(movieVM: MovieViewModel) { }
    
    func delete(id: Int64) { }
    
}
