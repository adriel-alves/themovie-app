//
//  MovieListViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 06/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import UIKit

class MovieListViewController: PopularMoviesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
