//
//  Constants.swift
//  SleepingInTheLibrary
//
//  Created by Jarrod Parkes on 11/5/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

import UIKit

// MARK: - Constants

struct Constants {
    
    // MARK: TMDB
    struct TMDB {
        static let ApiScheme            = "http"
        static let ApiHost              = "api.themoviedb.org"
        static let ApiPath              = "/3"
        
        // MARK: TMDB Parameter Keys
        struct ParameterKeys {
            static let ApiKey = "api_key"
            static let RequestToken = "request_token"
            static let SessionID = "session_id"
            static let Username = "username"
            static let Password = "password"
        }
        
        // MARK: TMDB Parameter Values
        struct ParameterValues {
            static let ApiKey = "YOUR_API_KEY_HERE"
        }
        
        // MARK: TMDB Response Keys
        struct ResponseKeys {
            static let Title = "title"
            static let ID = "id"
            static let PosterPath = "poster_path"
            static let StatusCode = "status_code"
            static let StatusMessage = "status_message"
            static let SessionID = "session_id"
            static let RequestToken = "request_token"
            static let Success = "success"
            static let UserID = "id"
            static let Results = "results"
        }
        
        // MARK: TMDB ImageSize
        struct ImageSize {
            struct BACKDROP {
                static let w300         = "w300"
                static let w780         = "w780"
                static let w1280        = "w1280"
                static let original     = "original"
            }
            
            struct LOGO {
                static let w45          = "w45"
                static let w92          = "w92"
                static let w154         = "w154"
                static let w185         = "w185"
                static let w300         = "w300"
                static let w500         = "w500"
                static let original     = "original"
            }
            
            struct POSTER {
                static let w92          = "w92"
                static let w154         = "w154"
                static let w185         = "w185"
                static let w342         = "w342"
                static let w500         = "w500"
                static let w780         = "w780"
                static let original     = "original"
            }
            
            struct PROFILE {
                static let w45          = "w45"
                static let w185         = "w185"
                static let w632         = "w632"
                static let original     = "original"
            }
            
            struct STILL {
                static let w92          = "w92"
                static let w185         = "w185"
                static let w300         = "w300"
                static let original     = "original"
            }
        }
    }
    
    // MARK: UI
    struct UI {
        static let LoginColorTop = UIColor(red: 0.345, green: 0.839, blue: 0.988, alpha: 1.0).cgColor
        static let LoginColorBottom = UIColor(red: 0.023, green: 0.569, blue: 0.910, alpha: 1.0).cgColor
        static let GreyColor = UIColor(red: 0.702, green: 0.863, blue: 0.929, alpha:1.0)
        static let BlueColor = UIColor(red: 0.0, green:0.502, blue:0.839, alpha: 1.0)
    }
    
    // FIX: As of Swift 2.2, using strings for selectors has been deprecated. Instead, #selector(methodName) should be used.
    /*
     // MARK: Selectors
     struct Selectors {
     static let KeyboardWillShow: Selector = "keyboardWillShow:"
     static let KeyboardWillHide: Selector = "keyboardWillHide:"
     static let KeyboardDidShow: Selector = "keyboardDidShow:"
     static let KeyboardDidHide: Selector = "keyboardDidHide:"
     }
     */
}
