//
//  MapPresenter.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class MapPresenter: MapPresenterInferface {
    
    var view: MapViewInferface!
    
    func onInit(view: MapViewInferface) {
        self.view = view
    }
    
}
