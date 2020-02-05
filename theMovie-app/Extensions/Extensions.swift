//
//  Extensions.swift
//  theMovie-app
//
//  Created by Adriel Alves on 27/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupSearchController(delegate: UISearchBarDelegate) {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.barTintColor = UIColor(named: "defaultcolor")
        searchController.searchBar.backgroundColor = UIColor(named: "defaultcolor")
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = delegate
        navigationItem.searchController = searchController
       
    }
    
    func setupNavigationBarAppearance(appearance: UINavigationBarAppearance) {
        appearance.backgroundColor = UIColor(named: "defaultcolor")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
}



