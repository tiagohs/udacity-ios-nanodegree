//
//  HomeContract.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 23/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

protocol HomeViewInterface {
    
    func bindRecentPhotos(photos: Photos)
    func onError(message: String)
}

protocol HomePresenterInterface {
    
    func onInit(view: HomeViewInterface)
    func fetchRecentPhotos()
}
