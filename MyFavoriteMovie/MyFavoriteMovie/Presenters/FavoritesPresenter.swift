//
//  FavoritesPresenter.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class FavoritesPresenter: FavoritesPresenterInterface {
    
    var view: FavoritesViewInterface!
    var movieService: MovieService!
    
    func onInit(view: FavoritesViewInterface) {
        self.view = view
        self.movieService = MovieService()
    }
    
    func fetchFavoriteMovies(userID: Int?, sessionID: String?) {
        guard let userID = userID else {
            self.view?.onError(message: "Erro ao buscar os filmes, tente novamente.")
            return
        }
        guard let sessionID = sessionID else {
            self.view?.onError(message: "Erro ao buscar os filmes, tente novamente.")
            return
        }
        
        self.movieService.fetchFavoriteMovies(sessionID: sessionID, userID: userID, page: 0) { (movies, error) in
            guard error == nil else {
                self.view?.onError(message: error?.localizedDescription ?? "Erro ao buscar os filmes, tente novamente.")
                return
            }
            guard let movies = movies else {
                self.view?.onError(message: "Erro ao buscar os filmes, tente novamente.")
                return
            }
            
            self.view.bindMovies(movies: movies)
        }
    }
    
}
