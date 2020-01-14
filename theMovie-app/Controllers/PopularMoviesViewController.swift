//
//  PopularMoviesViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 26/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {
    
    @IBOutlet weak var cvPopularMovies: UICollectionView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    private let cellIdentifier = "ItemCollectionViewCell"
    private var popularMovies = PopularMoviesViewModel()
    private var movies: [MovieViewModel] = []
    private var itemCollectionViewCell = ItemCollectionViewCell()
    private let appearance = UINavigationBarAppearance()
    
    var loading = false
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularMovies.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cvPopularMovies?.reloadData()
    }
    
    private func setupUI(){
        setupNavigationBarAppearance()
        setupSearchBar()
        requestMovies()
        setupCollectionView()
        setupItemCollectionViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
            if let movie = sender as? MovieViewModel {
                vc.movie = movie
            }
        }
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil).setupSearchController()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupNavigationBarAppearance() {
        appearance.backgroundColor = UIColor(named: "defaultcolor")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    func setupCollectionView() {
        cvPopularMovies.delegate = self
        cvPopularMovies.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        cvPopularMovies.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setupItemCollectionViewCell() {
        itemCollectionViewCell.setupCollectionViewItemSize(with: cvPopularMovies)
    }
    
    private func requestMovies() {
        loading = true
        aiLoading.startAnimating()
        popularMovies.requestMovies(currentPage: currentPage)
    }
}

extension PopularMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cvPopularMovies.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.prepare(with: movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        performSegue(withIdentifier: "movieDetailSegue", sender: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 10 && !loading && movies.count != popularMovies.total{
            currentPage += 1
            popularMovies.requestMovies(currentPage: currentPage)
        }
    }
}

extension PopularMoviesViewController: PopularMoviesViewModelDelegate {
    
    func didFinishSuccessRequest() {
        movies = popularMovies.movies
        self.cvPopularMovies?.reloadData()
        aiLoading.stopAnimating()
        loading = false
    }
    
    func didFinishFailureRequest(error: APIError) {
        print(APIError.taskError(error: error))
    }
}

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        if searchText.isEmpty {
            movies = popularMovies.movies
        } else {
            var hasResult: Bool = false
            movies = popularMovies.movies.filter { (movie) -> Bool in
                hasResult = movie.title.lowercased().contains(searchText.lowercased())
                
                if !hasResult {
                   // chamar nova tela aqui
                }
                return hasResult
                
            }
        }
        cvPopularMovies?.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movies = popularMovies.movies

        cvPopularMovies?.reloadData()
    }
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //
    //        guard !searchText.isEmpty else {
    //            movies = popularMovies.movies
    //            cvPopularMovies?.reloadData()
    //
    //            return
    //        }
    //
    //        movies = popularMovies.movies.filter { (movie) -> Bool in
    //            return movie.title.contains(searchText)
    //        }
    //        cvPopularMovies?.reloadData()
    //    }
    
}
