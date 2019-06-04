//
//  LoginPresenter.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterInterface {
    
    var view: LoginViewInterface!
    var authService: AuthService!
    var appDelegate: AppDelegate!
    
    func onInit(view: LoginViewInterface, appDelegate: AppDelegate) {
        self.view = view
        self.authService = AuthService()
        self.appDelegate = appDelegate
    }
    
    func login(username: String, password: String) {
        self.requestToken() { (token) in
            self.loginWithToken(token, username, password)
        }
    }
    
    private func requestToken(_ completionHandler: @escaping (String) -> Void) {
        self.authService.createToken { (requestToken, error) in
            guard error == nil else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            guard let requestToken = requestToken else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            
            self.appDelegate.requestToken = requestToken
            completionHandler(requestToken)
        }
    }
    
    private func loginWithToken(_ token: String,_ username: String,_ password: String) {
        self.authService.loginWithToken(token, username, password) { (loginWithSuccess, error) in
            guard error == nil else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            
            guard let loginWithSuccess = loginWithSuccess, loginWithSuccess == true else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            
            self.getSessionID(token)
        }
    }
    
    private func getSessionID(_ token: String) {
        self.authService.getSessionID(token, { (sessionID, error) in
            guard error == nil else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            
            guard let sessionID = sessionID else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            
            self.appDelegate.sessionID = sessionID
            self.getUserID(sessionID)
        })
    }
    
    private func getUserID(_ sessionID: String) {
        self.authService.getUserID(sessionID) { (userID, error) in
            guard error == nil else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            
            guard let userID = userID else {
                self.view?.onError(message: "Erro ao realizar login, tente novamente.")
                self.view?.setUIEnabled(true)
                return
            }
            
            self.appDelegate.userID = userID
            self.view.onLoginComplete()
        }
    }
}
