//
//  SearchPresenter.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterInterface {
    
    var view: SearchViewInterface!
    var flickrService: FlickrService!
    
    func onInit(view: SearchViewInterface) {
        self.view = view
        self.flickrService = FlickrService()
    }
    
    func searchByPhrase(phrase: String?) {
        guard let phrase = phrase else {
            return
        }
        
        self.flickrService.searchPhotosByPhrase(phrase: phrase) { (photos, error) in
            guard error == nil else {
                self.view?.onError(message: error?.localizedDescription ?? "Erro ao buscar fotos recentes.")
                return
            }
            guard let photos = photos else {
                self.view?.onError(message: "Erro ao buscar fotos populares.")
                return
            }
            
            self.view?.onBindPhotos(photos: photos)
        }
    }
}
