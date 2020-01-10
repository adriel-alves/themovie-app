//
//  FavoriteMoviesManager.swift
//  theMovie-app
//
//  Created by Adriel Alves on 08/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FavoriteMoviesManager {
    
    var fetchedResultController: NSFetchedResultsController<FavoriteMovieData>!
    var favoriteMoviesData: [FavoriteMovieData] = []
    var context: NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    func loadFavoriteMovies(index: Int64) {
        let fetchRequest: NSFetchRequest<FavoriteMovieData> = FavoriteMovieData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "movieTitle", ascending: true)
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(index))
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            favoriteMoviesData = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFavoriteMovies(filtering: String = "") -> NSFetchedResultsController<FavoriteMovieData> {
        let fetchRequest: NSFetchRequest<FavoriteMovieData> = FavoriteMovieData.fetchRequest()
        let titleDescriptor = NSSortDescriptor(key: "movieTitle", ascending: true)
        let yearDescriptor = NSSortDescriptor(key: "movieYear", ascending: true)
        if !filtering.isEmpty {
            let predicate = NSPredicate(format: "movieTitle contains [c] %@", filtering)
            fetchRequest.predicate = predicate
        }
        
        fetchRequest.sortDescriptors = [titleDescriptor, yearDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
        
    }
    
    func deleteFavoriteMovies(index: Int) {
        let favoriteMovie = favoriteMoviesData[index]
        context.delete(favoriteMovie)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFavoriteMoviesById(id: Int64) {
        for favoriteMovie in favoriteMoviesData {
            if id == favoriteMovie.id {
                context.delete(favoriteMovie)
            }
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
