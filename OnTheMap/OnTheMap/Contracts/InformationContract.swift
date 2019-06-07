//
//  InformationContract.swift
//  OnTheMap
//
//  Created by Tiago Silva on 07/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol InformationViewInferface {
    
    func onError(message: String)
}

protocol InformationPresenterInferface {
    
    func onInit(view: InformationViewInferface)
}
