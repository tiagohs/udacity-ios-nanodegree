//
//  InformationPresenter.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class InformationPresenter: InformationPresenterInferface {
    
    var view: InformationViewInferface!
    
    func onInit(view: InformationViewInferface) {
        self.view = view
    }
    
}
