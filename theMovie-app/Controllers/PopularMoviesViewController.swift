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
    @IBOutlet weak var sbMovies: UISearchBar!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    
    private let cellIdentifier = "ItemCollectionViewCell"
    private var popularMovies = PopularMoviesViewModel()
    private var movies: [MovieViewModel] = []
    private var itemCollectionViewCell = ItemCollectionViewCell()
    
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
        sbMovies.delegate = self
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
        popularMovies.requestMovies()
    
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
}

extension PopularMoviesViewController: PopularMoviesViewModelDelegate {
    
    func didFinishSuccessRequest() {
        movies = popularMovies.movies
        self.cvPopularMovies?.reloadData()
    }
    
    func didFinishFailureRequest(error: APIError) {
        print(APIError.taskError(error: error))
    }
}

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text else { return }
        if searchText.isEmpty {
            movies = popularMovies.movies
        } else {
            movies = popularMovies.movies.filter { (movie) -> Bool in
                return movie.title.lowercased().contains(searchText.lowercased())
            }
        }
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
