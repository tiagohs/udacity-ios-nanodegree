//
//  HomeContract.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol HomeViewInterface {
    
    func bindMovies(movies: [Movie])
    func bindGenres(genres: [Genre])
    func onError(message: String)
}

protocol HomePresenterInterface {
    
    func onInit(view: HomeViewInterface)
    func fetchMoviesByGenre(genre: Genre)
    func fetchGenres()
    func fetchPopularMovies()
}
