//
//  SearchPresenter.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 10/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterInterface {
    
    var view: SearchViewInterface!
    var movieService: MovieService!
    
    func onInit(view: SearchViewInterface) {
        self.view = view
        self.movieService = MovieService()
    }
    
    func searchMovieBy(query: String) {
        self.movieService.searchMoviesBy(query: query, page: 1) { (movies, error) in
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
