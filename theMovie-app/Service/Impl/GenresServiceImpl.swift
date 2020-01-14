//
//  GenresServiceImpl.swift
//  theMovie-app
//
//  Created by Adriel Alves on 13/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation

class GenresServiceImpl: GenresService {
    
    private let client: HTTPClient
    private let apiDetails = APIRequest()
    private var genresList: [Genre] = []
    init(client: HTTPClient = HTTP()) {
        self.client = client
    }
    
    internal func getGenresList(completion: @escaping (Result<GenreList, APIError>) -> Void) {
        let request = apiDetails.request(path: "genre/movie/list", method: HTTPMethod.get)
        client.perform(request, completion)
    }
    
    func movieGenresList(genresIds: [Int]) -> [Genre] {
        getGenresList { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let genres):
                self.genresList = genres.genres
            }
        }
        return genresList.filter({genre in genresIds.contains(where: {$0 == genre.id})})
    }
    
}


