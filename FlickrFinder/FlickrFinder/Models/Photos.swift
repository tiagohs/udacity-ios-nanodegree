//
//  Photos.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 23/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class Photos {
    
    var page: Int?
    var pages: Int?
    var perPage: Int?
    var total: Int?
    var photos: [Photo] = []
    
    init() {
        
    }
    
    init?(json: [String: Any]?) {
        guard let json = json else {
            return nil
        }
        
        if let photosResult = json["photos"] as? [String : Any],
           let photosArray = photosResult["photo"] as? [[String: AnyObject]] {
            
            for photoResult in photosArray {
                if let photo = Photo(json: photoResult) {
                    photos.append(photo)
                } 
            }
            
            self.page = photosResult["page"] as? Int
            self.pages = photosResult["pages"] as? Int
            self.perPage = photosResult["perpage"] as? Int
            self.total = photosResult["total"] as? Int
        }
        
    }
    
    // MARK: Mocks
    
    static func PhotosMock() -> Photos {
        let photos = Photos(json: [
            "page": "1",
            "pages": "1",
            "total": "10"
        ] as [String: AnyObject])!
        
        photos.photos = Photo.PhotosMock() 
        
        return photos
    }
}
