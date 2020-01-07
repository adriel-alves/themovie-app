//
//  MovieDetailViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 30/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieGenres: UILabel!
    @IBOutlet weak var lbMovieYear: UILabel!
    @IBOutlet weak var tvMovieOverview: UITextView!
    @IBOutlet weak var btFavorite: UIButton!
    
    var movie: MovieViewModel!
    var favoriteMovie: FavoriteMovieData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }
    
    func prepare() {
        ivMoviePoster.load(url: movie.posterPath!)
        lbMovieTitle.text = movie.title
        lbMovieGenres.text = "lista dos generos"
        lbMovieYear.text = movie.year
        tvMovieOverview.text = movie.overview
    }
    
    @IBAction func favorite(_ sender: Any) {
        if favoriteMovie == nil {
            favoriteMovie = FavoriteMovieData(context: context)
            favoriteMovie.movieTitle = lbMovieTitle.text
            favoriteMovie.movieYear = lbMovieYear.text
            favoriteMovie.movieDetails = tvMovieOverview.text
            favoriteMovie.moviePoster = ivMoviePoster.image
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    

}
