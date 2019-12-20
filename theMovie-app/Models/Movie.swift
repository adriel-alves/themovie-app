//
//  Movie.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String = ""
    let genreID: [Int] = []
    let overview: String = ""
    let release: String?
    let posterPath: String?
    
    enum CodinKeys: String, CodingKey {
        case title
        case genresID = "genre_ids"
        case posterPath = "poster_path"
        case overview
        case release
    }
    
}
