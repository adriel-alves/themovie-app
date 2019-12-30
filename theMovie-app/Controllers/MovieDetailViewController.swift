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
    
    var movie: MovieViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }
    
    
    func prepare() {
        ivMoviePoster.load(url: movie.posterPath!)
        lbMovieTitle.text = movie.title
        lbMovieGenres.text = "lista dos generos"
        lbMovieYear.text = movie.releaseDate?.description
        tvMovieOverview.text = movie.overview
    }
    
    
    

}
