//
//  BaseService.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class BaseService {
    var baseParameters: [String : String]
    
    init() {
        baseParameters =
            [
                Constants.TMDB.ParameterKeys.ApiKey: Constants.TMDB.ApiKey,
                Constants.TMDB.ParameterKeys.Language: "pt-BR"
        ]
    }
    
    func createAppendToResponse(appendToResponse: [String]) -> String {
        return appendToResponse.joined(separator: ",")
    }
    
    func doRequest(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request, completionHandler: completionHandler)
        
        task.resume()
    }
    
    func tmdbURLFromParameters(_ parameters: [String:String], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.TMDB.ApiScheme
        components.host = Constants.TMDB.ApiHost
        components.path = Constants.TMDB.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    func onMoviesRequestResponse(_ response: URLResponse?, _ data: Data?,_ error: Error?,_ completionHandler: @escaping ([Movie]?, Error?) -> Void) {
        
        guard (error == nil) else {
            completionHandler(nil, error)
            return
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            completionHandler(nil, DefaultError(message: "There was an error with your request: \(error!)"))
            return
        }
        
        guard let data = data else {
            completionHandler(nil, DefaultError(message: "Error in Server"))
            return
        }
        
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
        } catch {
            completionHandler(nil, DefaultError(message: "Could not parse the data as JSON: '\(data)'"))
            return
        }
        
        if let _ = parsedResult[Constants.TMDB.ResponseKeys.StatusCode] as? Int {
            completionHandler(nil, DefaultError(message: "TheMovieDB returned an error. See the '\(Constants.TMDB.ResponseKeys.StatusCode)' and '\(Constants.TMDB.ResponseKeys.StatusMessage)' in \(String(describing: parsedResult))"))
            return
        }
        
        
        guard let results = parsedResult[Constants.TMDB.ResponseKeys.Results] as? [[String:AnyObject]] else {
            print("Cannot find key '\(Constants.TMDB.ResponseKeys.Results)' in \(String(describing: parsedResult))")
            return
        }
        
        let movies = Movie.moviesFromResults(results)
        
        completionHandler(movies, nil)
    }
    
    func onGenresRequestResponse(_ response: URLResponse?, _ data: Data?,_ error: Error?,_ completionHandler: @escaping ([Genre]?, Error?) -> Void) {
        
        guard (error == nil) else {
            completionHandler(nil, error)
            return
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            completionHandler(nil, DefaultError(message: "There was an error with your request: \(error!)"))
            return
        }
        
        guard let data = data else {
            completionHandler(nil, DefaultError(message: "Error in Server"))
            return
        }
        
        let parsedResult: [String:AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
        } catch {
            completionHandler(nil, DefaultError(message: "Could not parse the data as JSON: '\(data)'"))
            return
        }
        
        guard let results = parsedResult[Constants.TMDB.ResponseKeys.Genres] as? [[String:AnyObject]] else {
            print("Cannot find key '\(Constants.TMDB.ResponseKeys.Genres)' in \(String(describing: parsedResult))")
            completionHandler(nil, DefaultError(message: "Cannot find key '\(Constants.TMDB.ResponseKeys.Genres)' in \(String(describing: parsedResult))"))
            return
        }
        
        let genres = Genre.genresFromResults(results)
        
        completionHandler(genres, nil)
    }
    
}
