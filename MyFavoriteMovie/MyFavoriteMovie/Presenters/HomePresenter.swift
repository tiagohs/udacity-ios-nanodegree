//
//  HomePresenter.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterInterface {
    
    var view: HomeViewInterface!
    var movieService: MovieService!
    var genreSerivce: GenreService!
    
    func onInit(view: HomeViewInterface) {
        self.view = view
        self.movieService = MovieService()
        self.genreSerivce = GenreService()
    }
    
    func fetchGenres() {
        self.genreSerivce.fetchGenres { (genres, error) in
            guard error == nil else {
                self.view?.onError(message: error?.localizedDescription ?? "Erro ao buscar os filmes, tente novamente.")
                return
            }
            guard let genres = genres else {
                self.view?.onError(message: "Erro ao buscar os gêneros, tente novamente.")
                return
            }
            
            let popularItem = Genre(dictionary: [
                "id": Constants.POPULAR_ITEM_ID as AnyObject,
                "name": "Populares" as AnyObject
            ])
            
            self.view.bindGenres(genres: [popularItem] + genres )
        }
    }
    
    func fetchMoviesByGenre(genre: Genre) {
        guard let id = genre.id else {
            view.onError(message: "Algo deu errado ao buscar os filmes, tente novamente.")
            return
        }
        
        if (genre.id == Constants.POPULAR_ITEM_ID) {
            fetchPopularMovies()
            return
        }
        
        self.movieService.fetchMoviesBy(genreID: id, page: 0) { (movies, error) in
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
    
    func fetchPopularMovies() {
        self.movieService.fetchPopularMovies { (movies, error) in
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
