//
//  FavoriteMoviesTableViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 07/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import UIKit
import CoreData

class FavoriteMoviesTableViewController: UITableViewController {
    
    private var fetchedResults: NSFetchedResultsController<FavoriteMovieData>!
    private var label = UILabel()
    private let cellIdentifier = "favoriteMovieCell"
    private var result = FavoriteMoviesManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Sem filmes cadastrados"
        label.textAlignment = .center
        loadFavoriteMovies()
    }
    
    func loadFavoriteMovies() {
        
        fetchedResults = result.loadFavoriteMovies()
        fetchedResults.delegate = self
        
        do {
            try fetchedResults.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteFavoriteMovies() {
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResults.fetchedObjects?.count ?? 0
        tableView.backgroundView = count == 0 ? label : nil
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoriteMovieTableViewCell
        
        guard let favoriteMovie = fetchedResults.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.prepare(with: favoriteMovie)
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension FavoriteMoviesTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.reloadData()
        case .delete:
            tableView.reloadData()
        default:
            tableView.reloadData()
        }
        
    }
    
}
