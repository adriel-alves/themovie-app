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
    
    private let cellIdentifier = "ItemCollectionViewCell"
    private var popularMovies = PopularMoviesViewModel()
    private var collectionViewFlowLayout: UICollectionViewFlowLayout!
    private var movies: [MovieViewModel] = []
    
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
        setupCollectionViewItemSize()
        
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
    
    private func setupCollectionView() {
        cvPopularMovies.delegate = self
        cvPopularMovies.dataSource = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        cvPopularMovies.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    private func setupCollectionViewItemSize() {
        let itemsPerRow: CGFloat = 2
        let lineSpacing: CGFloat = 3
        let interItemSpacing: CGFloat = 1
        
        let width = (cvPopularMovies.frame.width - (itemsPerRow - 1) * interItemSpacing) / itemsPerRow
        let height = width * 1.5
        
        collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
        
        cvPopularMovies.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        
    }
    
    private func requestMovies() {
        popularMovies.requestMovies()
    }
    
}

extension PopularMoviesViewController: UICollectionViewDataSource {
    
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
    
}

extension PopularMoviesViewController: UICollectionViewDelegate {
    
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
        if searchBar.text!.isEmpty {
            movies = popularMovies.movies
        } else {
            movies = popularMovies.movies.filter { (movie) -> Bool in
                return movie.title.contains(searchBar.text!)
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

