//
//  MovieService.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class MovieService: BaseService {
    
    func fetchPopularMovies(completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        let url = tmdbURLFromParameters(self.baseParameters, withPathExtension: "/movie/popular")
        
        doRequest(with: url) { (data, response, error) in
            self.onMoviesRequestResponse(response, data, error, completionHandler)
        }
    }
    
    func fetchMoviesBy(genreID: Int, page: Int, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.Page: String(page)
        ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/genre/\(genreID)/movies")
        
        doRequest(with: url) { (data, response, error) in
            self.onMoviesRequestResponse(response, data, error, completionHandler)
        }
    }
    
    func fetchFavoriteMovies(sessionID: String, userID: Int, page: Int, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.Page: String(page),
            Constants.TMDB.ParameterKeys.SessionID: sessionID
        ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/account/\(userID)/favorite/movies")
        
        doRequest(with: url) { (data, response, error) in
            self.onMoviesRequestResponse(response, data, error, completionHandler)
        }
    }
}
