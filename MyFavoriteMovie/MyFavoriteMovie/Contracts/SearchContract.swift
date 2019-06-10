//
//  SearchContract.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 10/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol SearchViewInterface {
    
    func bindMovies(movies: [Movie])
    func onError(message: String)
}

protocol SearchPresenterInterface {
    
    func onInit(view: SearchViewInterface)
    func searchMovieBy(query: String)
}

