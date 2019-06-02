//
//  HomePresenter.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 23/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterInterface {
    
    var view: HomeViewInterface?
    var flickrService: FlickrService!
    
    func onInit(view: HomeViewInterface) {
        self.view = view
        self.flickrService = FlickrService()
    }
    
    func fetchRecentPhotos() {
        self.flickrService.fetchRecentPhotos { (photos, error) in
            guard error == nil else {
                self.view?.onError(message: error?.localizedDescription ?? "Erro ao buscar fotos recentes.")
                return
            }
            guard let photos = photos else {
                self.view?.onError(message: "Erro ao buscar fotos populares.")
                return
            }
            
            photos.photos = Array(photos.photos[0..<10])
            
            self.view?.bindRecentPhotos(photos: photos)
        }
    }
    
}
