//
//  Constants.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

struct Constants {
    
    static let isMock = false
    static let ImageMockURL = "https://lh3.googleusercontent.com/aqceHxeWTZO1aqU9NaG5HwPXV5zwifBEH2fXty3e9OpPaZA-fSdFMAHMkIidF1_uJfWxHdPz=w640-h400-e365"
    
    // MARK: Flickr
    struct Flickr {
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest"
        
        static let SearchBBoxHalfWidth = 1.0
        static let SearchBBoxHalfHeight = 1.0
        static let SearchLatRange = (-90.0, 90.0)
        static let SearchLonRange = (-180.0, 180.0)
    }
    
    // MARK: Flickr Parameter Keys
    struct FlickrParameterKeys {
        static let Method = "method"
        static let APIKey = "api_key"
        static let GalleryID = "gallery_id"
        static let Extras = "extras"
        static let Format = "format"
        static let NoJSONCallback = "nojsoncallback"
        static let SafeSearch = "safe_search"
        static let Text = "text"
        static let BoundingBox = "bbox"
        static let Page = "page"
    }
    
    // MARK: Flickr Parameter Values
    struct FlickrParameterValues {
        static let APIKey = "7307d53891f94571457b4c80bdd286b6"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1" /* 1 means "yes" */
        static let GalleryID = "5704-72157622566655097"
        static let MediumURL = "url_m"
        static let UseSafeSearch = "1"
        
        
        struct Methods {
            static let GalleryGetPhotos = "flickr.galleries.getPhotos"
            
            static let PhotosSearch = "flickr.photos.search"
            static let PhotosGetPopular = "flickr.photos.getPopular"
            static let PhotosGetRecent = "flickr.photos.getRecent"
        }
    }
    
    // MARK: Flickr Response Keys
    struct FlickrResponseKeys {
        static let Status = "stat"
        static let Photos = "photos"
        static let Photo = "photo"
        static let Title = "title"
        static let MediumURL = "url_m"
        static let Pages = "pages"
        static let Total = "total"
    }
    
    // MARK: Flickr Response Values
    struct FlickrResponseValues {
        static let OKStatus = "ok"
    }
}
