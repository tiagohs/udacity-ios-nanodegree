//
//  ViewController.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class LoginController: BaseController {
    
    var presenter: LoginPresenterInferface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = LoginPresenter()
        self.presenter.onInit(view: self)
    }

}

extension LoginController: LoginViewInferface {
    
}
