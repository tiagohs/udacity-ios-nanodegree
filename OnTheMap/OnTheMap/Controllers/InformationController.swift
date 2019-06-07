//
//  InformationController.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class InformationController: BaseController {
    
    var presenter: InformationPresenterInferface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = InformationPresenter()
        self.presenter.onInit(view: self)
    }
}

extension InformationController: InformationViewInferface {
    
}
