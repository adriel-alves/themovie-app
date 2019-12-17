//
//  PopularMovie.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

class PopularMovie: Codable {
    var page: Int = 0
    var totalResults: Int = 0
    var totalPages: Int = 0
    var movies: [Movie] = []
    
}
