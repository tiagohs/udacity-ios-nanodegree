//
//  SearchContract.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol SearchViewInterface {
    
    func onBindPhotos(photos: Photos)
    func onError(message: String)
}

protocol SearchPresenterInterface {
    
    func onInit(view: SearchViewInterface)
    func searchByPhrase(phrase: String?)
}
