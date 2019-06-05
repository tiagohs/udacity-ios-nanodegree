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
    
    func fetchUserWacthlis(sessionID: String, userID: Int, page: Int, completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.Page: String(page),
            Constants.TMDB.ParameterKeys.SessionID: sessionID
            ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/account/\(userID)/watchlist/movies")
        
        doRequest(with: url) { (data, response, error) in
            self.onMoviesRequestResponse(response, data, error, completionHandler)
        }
    }
    
    func addMovieToWatchlist(movieID: Int, shouldAddToWatchlist: Bool, sessionID: String, userID: Int, completionHandler: @escaping (Bool?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.SessionID: sessionID
        ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/account/\(userID)/watchlist")
        let body = "{\"media_type\": \"movie\",\"media_id\": \(movieID),\"watchlist\":\(shouldAddToWatchlist)}"
        
        doPOSTRequest(with: url, bodyString: body) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, DefaultError(message: "There was an error with your request: \(String(describing: error))"))
                return
            }
            
            guard let data = data else {
                completionHandler(nil, DefaultError(message: "Error in Server"))
                return
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
            } catch {
                completionHandler(nil, DefaultError(message: "Could not parse the data as JSON: '\(data)'"))
                return
            }
            
            /* GUARD: Did we receive a TMDB status_code? */
            guard let tmdbStatusCode = parsedResult[Constants.TMDB.ResponseKeys.StatusCode] as? Int else {
                completionHandler(nil, DefaultError(message: "Could not find key '\(Constants.TMDB.ResponseKeys.StatusCode)' in  \(String(describing: parsedResult))"))
                return
            }
            
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
    
    func markAsFavorite(movieID: Int, isFavorite: Bool, sessionID: String, userID: Int, completionHandler: @escaping (Bool?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.SessionID: sessionID
            ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/account/\(userID)/favorite")
        let body = "{\"media_type\": \"movie\",\"media_id\": \(movieID),\"favorite\":\(isFavorite)}"
        
        doPOSTRequest(with: url, bodyString: body) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, DefaultError(message: "There was an error with your request: \(String(describing: error))"))
                return
            }
            
            guard let data = data else {
                completionHandler(nil, DefaultError(message: "Error in Server"))
                return
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
            } catch {
                completionHandler(nil, DefaultError(message: "Could not parse the data as JSON: '\(data)'"))
                return
            }
            
            guard let tmdbStatusCode = parsedResult[Constants.TMDB.ResponseKeys.StatusCode] as? Int else {
                completionHandler(nil, DefaultError(message: "Could not find key '\(Constants.TMDB.ResponseKeys.StatusCode)' in  \(String(describing: parsedResult))"))
                return
            }
            
            /* GUARD: Did we receive the correct TMDB status_code? */
            if isFavorite && !(tmdbStatusCode == 12 || tmdbStatusCode == 1) {
                completionHandler(nil, DefaultError(message: "Unrecognized '\(Constants.TMDB.ResponseKeys.StatusCode)' in  \(String(describing: parsedResult))"))
                return
            } else if !isFavorite && tmdbStatusCode != 13 {
                completionHandler(nil, DefaultError(message: "Unrecognized '\(Constants.TMDB.ResponseKeys.StatusCode)' in  \(String(describing: parsedResult))"))
                return
            }
            
            completionHandler(isFavorite, nil)
        }
    }
    
}
