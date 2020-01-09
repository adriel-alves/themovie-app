//
//  FavoriteMoviesManager.swift
//  theMovie-app
//
//  Created by Adriel Alves on 08/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation
import CoreData

class FavoriteMoviesManager {
    
    var fetchedResultController: NSFetchedResultsController<FavoriteMovieData>!
    
    func loadFavoriteMovies(context: NSManagedObjectContext) -> NSFetchedResultsController<FavoriteMovieData> {
        let fetchRequest: NSFetchRequest<FavoriteMovieData> = FavoriteMovieData.fetchRequest()
        let titleDescriptor = NSSortDescriptor(key: "movieTitle", ascending: true)
        let yearDescriptor = NSSortDescriptor(key: "movieYear", ascending: true)
        fetchRequest.sortDescriptors = [titleDescriptor, yearDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController

    }
    
}
