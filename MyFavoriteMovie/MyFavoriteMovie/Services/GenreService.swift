//
//  GenreService.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class GenreService: BaseService {
    
    func fetchGenres(completionHandler: @escaping ([Genre]?, Error?) -> Void) {
        let url = tmdbURLFromParameters(baseParameters, withPathExtension: "/genre/movie/list")
        
        doRequest(with: url) { (data, response, error) in
            self.onGenresRequestResponse(response, data, error, completionHandler)
        }
    }
}
