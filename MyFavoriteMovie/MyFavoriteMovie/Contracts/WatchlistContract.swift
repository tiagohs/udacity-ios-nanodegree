//
//  WatchlistContract.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 06/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol WatchlistViewInterface {
    
    func bindMovies(movies: [Movie])
    func onError(message: String)
}

protocol WatchlistPresenterInterface {
    
    func onInit(view: WatchlistViewInterface, appDelegate: AppDelegate)
    func fetchWatchlist()
}

