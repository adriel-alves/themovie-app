//
//  Movie.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

class Movie: Codable {
    
    var id: Int
    var title: String = ""
    var genres: [Int] = []
    var overview: String = ""
    var release: String?
    var posterPath: String?
    
}
