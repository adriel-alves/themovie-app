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
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    var popularMovies = PopularMoviesViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        requestMovies()
        setupCollectionView()
        setupCollectionViewItemSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.cvPopularMovies?.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
            if let movie = sender as? MovieViewModel {
            vc.movie = movie
            }
        }
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
        return popularMovies.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvPopularMovies.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.prepare(with: popularMovies.movies[indexPath.item])
        return cell
    }
    
}

extension PopularMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = popularMovies.movies[indexPath.item]
        performSegue(withIdentifier: "movieDetailSegue", sender: movie)
    }
}




