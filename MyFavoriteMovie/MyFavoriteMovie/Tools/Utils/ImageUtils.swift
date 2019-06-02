//
//  ImageUtils.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class ImageUtils {
    
    static func formatImageUrl(imageID: String?, imageSize: String) -> String? {
        guard let id = imageID else {
            return nil
        }
        
        return "\(Constants.TMDB.ApiBaseImageUrl)\(imageSize)/\(id)"
    }
}
