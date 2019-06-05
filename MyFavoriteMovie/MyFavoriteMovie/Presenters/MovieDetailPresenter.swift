//
//  MovieDetailPresenter.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 04/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterInterface {
    
    var view: MovieDetailViewInterface!
    var appDelegate: AppDelegate!
    var accountService: AccountService!
    
    func onInit(view: MovieDetailViewInterface, appDelegate: AppDelegate) {
        self.view = view
        self.appDelegate = appDelegate
        self.accountService = AccountService()
    }
    
    func checkMovieState(movie: Movie) {
        guard let movieID = movie.id else {
            self.view?.onError(message: "Erro ao buscar informações sobre o filme, tente novamente.")
            return
        }
        
        guard let userID = appDelegate.userID else {
            self.view?.onError(message: "Erro ao buscar informações sobre o filme, tente novamente.")
            return
        }
        
        guard let sessionID = appDelegate.sessionID else {
            self.view?.onError(message: "Erro ao buscar informações sobre o filme, tente novamente.")
            return
        }
        
        self.accountService.isMovieFavorite(currentMovieId: movieID, sessionID: sessionID, userID: userID) { (isFavorite, error) in
            guard error == nil else {
                self.view?.onError(message: error?.localizedDescription ?? "Erro ao buscar informações sobre o filme, tente novamente.")
                return
            }
            guard let isFavorite = isFavorite else {
                self.view?.onError(message: "Erro ao buscar informações sobre o filme, tente novamente.")
                return
            }
            
            movie.isFavorite = isFavorite
            
            self.view.bindMovie(movie: movie)
        }
    }
    
    func markAsFavorite(_ movie: Movie, _ isFavorite: Bool) {
        guard let movieID = movie.id else {
            self.view?.onError(message: "Erro ao buscar informações sobre o filme, tente novamente.")
            return
        }
        
        guard let userID = appDelegate.userID else {
            self.view?.onError(message: "Erro ao buscar informações sobre o filme, tente novamente.")
            return
        }
        
        guard let sessionID = appDelegate.sessionID else {
            self.view?.onError(message: "Erro ao buscar informações sobre o filme, tente novamente.")
            return
        }
        
        self.accountService.markAsFavorite(movieID: movieID, isFavorite: isFavorite, sessionID: sessionID, userID: userID) { (isFavorite, error) in
            guard error == nil else {
                self.view?.onError(message: error?.localizedDescription ?? "Erro ao salvar como favorito, tente novamente.")
                return
            }
            guard let isFavorite = isFavorite else {
                self.view?.onError(message: "Erro ao salvar como favorito.")
                return
            }
            
            self.view?.updateFavoriteButton(isFavorite)
        }
    }
    
    
}
