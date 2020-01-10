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
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func loadFavoriteMovies(filter: String = "") {
        
        fetchedResults = result.loadFavoriteMovies(filtering: filter)
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteMovieTableViewCell else {
            return UITableViewCell()
        }
        guard let favoriteMovie = fetchedResults.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.prepare(with: favoriteMovie)
        return cell
    }
}

extension FavoriteMoviesTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            tableView.reloadData()
        case .insert:
            tableView.reloadData()
        default:
            tableView.reloadData()
        }
    }
}

extension FavoriteMoviesTableViewController: UISearchBarDelegate {
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadFavoriteMovies()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadFavoriteMovies(filter: searchBar.text!)
        tableView.reloadData()
    }
}
