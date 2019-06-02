//
//  Album.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 23/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import Foundation

class Album {
    var id: Int!
    var title: String?
    var photos: [Photo] = []
    
    // MARK: Mocks
    
    static func AlbumMock(id: Int) -> Album {
        let album = Album()
        
        album.id = id
        album.title = "Album Title \(id)"
        album.photos = Photo.PhotosMock()
        
        return album
    }
    
    static func AlbumsMock() -> [Album] {
        return [
            Album.AlbumMock(id: 1),
            Album.AlbumMock(id: 2),
            Album.AlbumMock(id: 3),
            Album.AlbumMock(id: 4),
            Album.AlbumMock(id: 5),
            Album.AlbumMock(id: 6),
            Album.AlbumMock(id: 7),
            Album.AlbumMock(id: 8),
            Album.AlbumMock(id: 9),
            Album.AlbumMock(id: 10),
        ]
    }
}
