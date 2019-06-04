//
//  FavoriteContract.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation


protocol FavoritesViewInterface {
    
    func bindMovies(movies: [Movie])
    func onError(message: String)
}

protocol FavoritesPresenterInterface {
    
    func onInit(view: FavoritesViewInterface, appDelegate: AppDelegate)
    func fetchFavoriteMovies()
}

