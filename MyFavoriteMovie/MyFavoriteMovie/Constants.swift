//
//  Constants.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

struct Constants {
    
    static let POPULAR_ITEM_ID = 0
    
    // MARK: TMDB
    struct TMDB {
        static let ApiKey               = "dac4d50f24dee29513738d8fa3470a3f"
        static let ApiScheme            = "https"
        static let ApiHost              = "api.themoviedb.org"
        static let ApiPath              = "/3"
        static let ApiBaseImageUrl      = "https://image.tmdb.org/t/p/"
        
        static let SignUpURL            = "https://www.themoviedb.org/account/signup"
        static let ForgotPasswordURL    = "https://www.themoviedb.org/account/reset-password"
        
        // MARK: TMDB Parameter Keys
        struct ParameterKeys {
            static let ApiKey           = "api_key"
            static let RequestToken     = "request_token"
            static let SessionID        = "session_id"
            static let Username         = "username"
            static let Password         = "password"
            static let Language         = "language"
            static let Page             = "page"
        }
        
        // MARK: TMDB Parameter Values
        struct ParameterValues {
            static let ApiKey = "YOUR_API_KEY_HERE"
        }
        
        // MARK: TMDB Response Keys
        struct ResponseKeys {
            struct Movie {
                static let VoteCount = "vote_count"
                static let Id = "id"
                static let Video = "video"
                static let VoteAverage = "vote_average"
                static let Title = "title"
                static let Popularity = "popularity"
                static let PosterPath = "poster_path"
                static let OriginalLanguage = "original_language"
                static let OriginalTitle = "original_title"
                static let GenreIds = "genre_ids"
                static let BackdropPath = "backdrop_path"
                static let Adult = "adult"
                static let Overview = "overview"
                static let ReleaseDate = "release_date"
            }
            
            struct Genre {
                static let Id = "id"
                static let Name = "name"
            }
            
            static let PosterPath = "poster_path"
            static let StatusCode = "status_code"
            static let StatusMessage = "status_message"
            static let SessionID = "session_id"
            static let RequestToken = "request_token"
            static let Success = "success"
            static let UserID = "id"
            static let Results = "results"
            static let Genres = "genres"
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
    
    struct COLOR {
        static let colorPrimary             = "#673ab7"
        static let colorPrimaryDark         = "#4527a0"
        static let colorPrimaryLight        = "#7e57c2"
        static let colorAccent              = "#f44336"
    }
    
    struct Assets {
        static let BackdropPlaceholder          = "BackdropPlaceholder"
        static let MoviePlaceholder             = "MoviePlaceholder"
        static let MovieIcon                    = "MovieIcon"
    }
}
