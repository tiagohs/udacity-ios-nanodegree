//
//  WachlistPresenter.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 06/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class WatchlistPresenter: WatchlistPresenterInterface {
    
    var view: WatchlistViewInterface!
    var accountService: AccountService!
    var appDelegate: AppDelegate!
    
    func onInit(view: WatchlistViewInterface, appDelegate: AppDelegate) {
        self.view = view
        self.appDelegate = appDelegate
        self.accountService = AccountService()
    }
    
    func fetchWatchlist() {
        
        guard let userID = appDelegate.userID else {
            self.view?.onError(message: "Erro ao buscar os filmes, tente novamente.")
            return
        }
        guard let sessionID = appDelegate.sessionID else {
            self.view?.onError(message: "Erro ao buscar os filmes, tente novamente.")
            return
        }
        
        self.accountService.fetchUserWatchlist(sessionID: sessionID, userID: userID, page: 1) {  (movies, error) in
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
