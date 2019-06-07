//
//  LoginPresenter.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterInferface {
    
    var view: LoginViewInferface!
    
    func onInit(view: LoginViewInferface) {
        self.view = view
    }
    
}
