//
//  MovieDetailViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 30/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieYear: UILabel!
    @IBOutlet weak var lbMovieGenres: UILabel!
    @IBOutlet weak var tvMovieOverview: UITextView!
    @IBOutlet weak var btFavorite: UIButton!
    
    var movie: MovieViewModel!
    private var favoriteMovie: FavoriteMovieData!
    private var favoriteManager = FavoriteMoviesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isFavorite()
    }
    
    func prepare() {
        ivMoviePoster.load(url: movie.posterPath!)
        lbMovieTitle.text = movie.title
        lbMovieGenres.text = "lista dos generos"
        lbMovieYear.text = movie.year
        tvMovieOverview.text = movie.overview
        btFavorite.setImage(movie.favoriteButtonImage, for: .normal)
    }
    
    func isFavorite() {
        btFavorite.setImage(movie.favoriteButtonImage, for: .normal)
    }
    
    @IBAction func addFavoriteMovie(_ sender: Any) {
        favoriteManager.loadFavoriteMovies(index: movie.id)
        if favoriteManager.favoriteMoviesData.count == 0 {
            favoriteMovie = FavoriteMovieData(context: favoriteManager.context)
            favoriteMovie.movieTitle = lbMovieTitle.text
            favoriteMovie.movieYear = lbMovieYear.text
            favoriteMovie.movieDetails = tvMovieOverview.text
            favoriteMovie.moviePoster = ivMoviePoster.image
            favoriteMovie.id = movie.id
            do {
                try favoriteManager.context.save()
                btFavorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            deleteFavoriteMovie()
            btFavorite.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        }
    }
    
    func deleteFavoriteMovie() {
        favoriteManager.deleteFavoriteMoviesById(id: movie.id)
    }
    
    
    
}
