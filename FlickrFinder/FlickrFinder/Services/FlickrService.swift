//
//  FlickrService.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class FlickrService: BaseService {
    
    private var baseParameters = [
        Constants.FlickrParameterKeys.SafeSearch: Constants.FlickrParameterValues.UseSafeSearch,
        Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
        Constants.FlickrParameterKeys.APIKey: Constants.FlickrParameterValues.APIKey,
        Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
        Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
    ]
    
    func fetchFeaturedAlbums(completionHandler: @escaping ([Album]?, Error?) -> Void) {
        
        if Constants.isMock {
            let albumsMocked = Album.AlbumsMock()
            
            completionHandler(albumsMocked, nil)
            return
        }
    }
    
    func fetchPopularPhotos(_ completionHandler: @escaping (Photos?, Error?) -> Void) {
        let parameters = baseParameters.merge(with: [
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.Methods.PhotosGetPopular
        ])
        
        doFlikrFetch(parameters: parameters, completionHandler)
    }
    
    func fetchRecentPhotos(_ completionHandler: @escaping (Photos?, Error?) -> Void) {
        let parameters = baseParameters.merge(with: [
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.Methods.PhotosGetRecent
        ])
        
        doFlikrFetch(parameters: parameters, completionHandler)
    }
    
    // MARK: Search Photos By Phrase
    func searchPhotosByPhrase(phrase: String,_ completionHandler: @escaping (Photos?, Error?) -> Void) {
        
        if Constants.isMock {
            let originalPhotos = Photos.PhotosMock()
            let findedPhotos = originalPhotos.photos.filter { (photo) -> Bool in
                return photo.title?.contains(phrase) ?? false
            }
            
            originalPhotos.photos = findedPhotos
            completionHandler(originalPhotos, nil)
            return
        }
        
        let parameters = baseParameters.merge(with: [
            Constants.FlickrParameterKeys.Text: phrase,
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.Methods.PhotosSearch
        ])
        
        doFlikrFetch(parameters: parameters, completionHandler)
    }
    
    private func doFlikrFetch(parameters: [String : String], _ completionHandler: @escaping (Photos?, Error?) -> Void) {
        let flickURL = flickURLFromParameters(parameters as [String : AnyObject])
        
        self.doRequest(with: flickURL) { (data, response, error) in
            self.onPhotosResponse(response, data, error, completionHandler)
        }
    }
    
    private func onPhotosResponse(_ response: URLResponse?, _ data: Data?,_ error: Error?, _ completionHandler: @escaping (Photos?, Error?) -> Void) {
        guard (error == nil) else {
            completionHandler(nil, error)
            return
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
            statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, DefaultError(message: "Error in Server"))
                return
        }
        
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:AnyObject]
            
            guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String, stat == Constants.FlickrResponseValues.OKStatus else {
                completionHandler(nil, DefaultError(message: "Error in Server"))
                return
            }
            
            guard let parsedPhotos: Photos = Photos(json: parsedResult) else {
                completionHandler(nil, DefaultError(message: "Error in get photos"))
                return
            }
            
            completionHandler(parsedPhotos, nil)
        } catch {
            completionHandler(nil, DefaultError(message: "Error in Parser Results"))
        }
    }
    
    private func flickURLFromParameters(_ parameters: [String: AnyObject]) -> URL {
        var components = URLComponents()
        
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}
