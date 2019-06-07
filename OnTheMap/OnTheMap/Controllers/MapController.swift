//
//  MapController.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MapController: BaseController {
    
    var presenter: MapPresenterInferface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MapPresenter()
        self.presenter.onInit(view: self)
    }

}

extension MapController: MapViewInferface {
    
}
