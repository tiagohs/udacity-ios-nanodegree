//
//  TMDBUtils.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class TMDBUtils {
    
    static func formatGenresToStringFrom(arrayOfGenresID: [Int]?, genres: [Genre]?) -> String? {
        guard let genresID = arrayOfGenresID else { return nil }
        guard let genres = genres else { return nil }
        
        let genresFinded = genresID.map { (genreID) -> String in
            let genre = genres.first(where: { (g) -> Bool in
                return g.id == genreID
            })
            
            return genre?.name ?? ""
        }
        
        return genresFinded.joined(separator: ", ")
    }
}
