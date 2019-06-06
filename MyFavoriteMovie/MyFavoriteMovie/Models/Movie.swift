//
//  Movie.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class Movie {
    var voteCount : Int?
    var id : Int?
    var video : Bool?
    var voteAverage : Double?
    var title : String?
    var popularity : Double?
    var posterPath : String?
    var originalLanguage : String?
    var originalTitle : String?
    var genreIds : [Int]?
    var backdropPath : String?
    var adult : Bool?
    var overview : String?
    var releaseDate : String?
    var isFavorite: Bool = false
    var addedToWatchlist: Bool = false
    
    init(dictionary: [String:AnyObject]) {
        id = dictionary[Constants.TMDB.ResponseKeys.Movie.Id] as? Int
        title = dictionary[Constants.TMDB.ResponseKeys.Movie.Title] as? String
        voteCount = dictionary[Constants.TMDB.ResponseKeys.Movie.VoteCount] as? Int
        video = dictionary[Constants.TMDB.ResponseKeys.Movie.Video] as? Bool
        voteAverage = dictionary[Constants.TMDB.ResponseKeys.Movie.VoteAverage] as? Double
        popularity = dictionary[Constants.TMDB.ResponseKeys.Movie.Popularity] as? Double
        posterPath = dictionary[Constants.TMDB.ResponseKeys.Movie.PosterPath] as? String
        originalLanguage = dictionary[Constants.TMDB.ResponseKeys.Movie.OriginalLanguage] as? String
        originalTitle = dictionary[Constants.TMDB.ResponseKeys.Movie.OriginalTitle] as? String
        genreIds = dictionary[Constants.TMDB.ResponseKeys.Movie.GenreIds] as? [Int]
        originalTitle = dictionary[Constants.TMDB.ResponseKeys.Movie.OriginalTitle] as? String
        backdropPath = dictionary[Constants.TMDB.ResponseKeys.Movie.BackdropPath] as? String
        adult = dictionary[Constants.TMDB.ResponseKeys.Movie.Adult] as? Bool
        overview = dictionary[Constants.TMDB.ResponseKeys.Movie.Overview] as? String
        releaseDate = dictionary[Constants.TMDB.ResponseKeys.Movie.ReleaseDate] as? String
    }
    
    static func moviesFromResults(_ results: [[String:AnyObject]]) -> [Movie] {
        
        var movies = [Movie]()
        
        for result in results {
            movies.append(Movie(dictionary: result))
        }
        
        return movies
    }
}
