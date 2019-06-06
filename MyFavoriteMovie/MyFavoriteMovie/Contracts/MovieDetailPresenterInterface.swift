//
//  MovieDetailPresenterInterface.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 04/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol MovieDetailViewInterface {
    
    func bindMovie(movie: Movie)
    func onError(message: String)
    func updateFavoriteButton(_ isFavorite: Bool)
    func updateAddToWatchlistButton(_ addedToWatchlist: Bool)
}

protocol MovieDetailPresenterInterface {
    
    func onInit(view: MovieDetailViewInterface, appDelegate: AppDelegate)
    func checkMovieState(movie: Movie)
    func markAsFavorite(_ movie: Movie, _ isFavorite: Bool)
    func addToWatchlist(_ movie: Movie, _ addToWatchlist: Bool)
}
