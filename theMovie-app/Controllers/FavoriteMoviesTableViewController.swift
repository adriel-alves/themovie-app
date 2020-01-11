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
    
    private var label = UILabel()
    private let cellIdentifier = "favoriteMovieCell"
    private var favoriteMoviesManager = FavoriteMoviesManager()
    private var favoriteMovieData: [FavoriteMovieData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Sem filmes cadastrados"
        label.textAlignment = .center
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavoriteMovies()
        tableView.reloadData()
    }
    
    func setupSearchBar() {
        let searchController = UISearchController().setupSearchController()
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func loadFavoriteMovies(filter: String = "") {
        favoriteMoviesManager.loadFavoriteMovies(filtering: filter)
        self.favoriteMovieData = favoriteMoviesManager.favoriteMoviesData
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        tableView.backgroundView = favoriteMovieData.count == 0 ? label : nil
        return favoriteMovieData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteMovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.prepare(with: favoriteMovieData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let favoriteMovie = favoriteMovieData[indexPath.row]
            favoriteMoviesManager.deleteFavoriteMoviesById(id: favoriteMovie.id)
            favoriteMovieData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
