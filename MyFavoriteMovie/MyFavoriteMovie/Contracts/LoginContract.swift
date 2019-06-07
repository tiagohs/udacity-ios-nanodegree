//
//  LoginContract.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol LoginViewInterface {
    
    func onError(message: String)
    func setUIEnabled(_ enabled: Bool)
    func onLoginAuthConfigurationComplete(requestToken: String, request: URLRequest,_ completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: Error?) -> Void)
    func onLoginComplete()
}

protocol LoginPresenterInterface {
    
    func onInit(view: LoginViewInterface, appDelegate: AppDelegate)
    func login(username: String, password: String)
    func loginWithAuth()
}
