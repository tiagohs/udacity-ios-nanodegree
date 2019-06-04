//
//  Genre.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class Genre {
    var id: Int?
    var name: String?
    
    init(dictionary: [String:AnyObject]) {
        id = dictionary[Constants.TMDB.ResponseKeys.Genre.Id] as? Int
        name = dictionary[Constants.TMDB.ResponseKeys.Genre.Name] as? String
    }
    
    static func genresFromResults(_ results: [[String:AnyObject]]) -> [Genre] {
        
        var genres = [Genre]()
        
        for result in results {
            genres.append(Genre(dictionary: result))
        }
        
        return genres
    }
}
