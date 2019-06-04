//
//  UserService.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class AuthService: BaseService {
    
    func createToken(_ completionHandler: @escaping (String?, Error?) -> Void) {
        let url = tmdbURLFromParameters(baseParameters, withPathExtension: "/authentication/token/new")
        
        doRequest(with: url) { (data, response, error) in
            guard (error == nil) else {
                completionHandler(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, DefaultError(message: "There was an error with your request: \(String(describing: error))"))
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
            
            guard let requestToken = parsedResult[Constants.TMDB.ResponseKeys.RequestToken] as? String else {
                completionHandler(nil, DefaultError(message: "Cannot find key '\(Constants.TMDB.ResponseKeys.RequestToken)' in \(String(describing: parsedResult))"))
                return
            }
            
            completionHandler(requestToken, nil)
        }
    }
    
    func loginWithToken(_ token: String,_ username: String,_ password: String,_ completionHandler: @escaping (Bool?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.RequestToken: token,
            Constants.TMDB.ParameterKeys.Username: username,
            Constants.TMDB.ParameterKeys.Password: password
        ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/authentication/token/validate_with_login")
        
        doRequest(with: url) { (data, response, error) in
            guard (error == nil) else {
                completionHandler(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, DefaultError(message: "There was an error with your request: \(String(describing: error))"))
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
            
            guard let success = parsedResult[Constants.TMDB.ResponseKeys.Success] as? Bool, success == true else {
                completionHandler(nil, DefaultError(message: "Cannot find key '\(Constants.TMDB.ResponseKeys.Success)' in \(String(describing: parsedResult))"))
                return
            }
            
            completionHandler(success, nil)
        }
    }
    
    func getSessionID(_ token: String,_ completionHandler: @escaping (String?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.RequestToken: token
        ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/authentication/session/new")
        
        doRequest(with: url) { (data, response, error) in
            guard (error == nil) else {
                completionHandler(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, DefaultError(message: "There was an error with your request: \(String(describing: error))"))
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
            
            guard let sessionID = parsedResult[Constants.TMDB.ResponseKeys.SessionID] as? String else {
                completionHandler(nil, DefaultError(message: "Cannot find key '\(Constants.TMDB.ResponseKeys.SessionID)' in \(String(describing: parsedResult))"))
                return
            }
            
            completionHandler(sessionID, nil)
        }
    }
    
    func getUserID(_ sessionID: String,_ completionHandler: @escaping (Int?, Error?) -> Void) {
        let parameters = self.baseParameters.merge(with: [
            Constants.TMDB.ParameterKeys.SessionID: sessionID
            ])
        
        let url = tmdbURLFromParameters(parameters, withPathExtension: "/account")
        
        doRequest(with: url) { (data, response, error) in
            guard (error == nil) else {
                completionHandler(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                completionHandler(nil, DefaultError(message: "There was an error with your request: \(String(describing: error))"))
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
            
            guard let userID = parsedResult[Constants.TMDB.ResponseKeys.UserID] as? Int else {
                completionHandler(nil, DefaultError(message: "Cannot find key '\(Constants.TMDB.ResponseKeys.UserID)' in \(String(describing: parsedResult))"))
                return
            }
            
            completionHandler(userID, nil)
        }
    }
}
