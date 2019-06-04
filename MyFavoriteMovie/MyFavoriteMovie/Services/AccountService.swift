//
//  AccountService.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 04/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class AccountService: BaseService {
    
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
    
    func isMovieFavorite(currentMovieId: Int, sessionID: String, userID: Int, completionHandler: @escaping (Bool?, Error?) -> Void) {
        var isFavorite = false
        
        fetchFavoriteMovies(sessionID: sessionID, userID: userID, page: 1) { (movies, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard let favoriteMovies = movies else {
                completionHandler(nil, DefaultError(message: "Erro ao buscar os filmes, tente novamente."))
                return
            }
            
            for favoriteMovie in favoriteMovies {
                if currentMovieId == favoriteMovie.id {
                    isFavorite = true
                }
            }
            
            completionHandler(isFavorite, nil)
        }
    }
}
