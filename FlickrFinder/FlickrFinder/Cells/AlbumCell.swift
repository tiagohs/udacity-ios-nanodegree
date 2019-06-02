//
//  AlbumCell.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 23/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell { 
    
    @IBOutlet weak var albumPhotoImageView: UIImageView!
    @IBOutlet weak var albumPhotoOpacityView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfPhotosLabel: UILabel!
    
    var album: Album? {
        didSet { bindAlbum(album!) }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func bindAlbum(_ album: Album) {
        titleLabel.text = album.title
        
        let numberOfPhotos = album.photos.count
        if numberOfPhotos > 0 {
            numberOfPhotosLabel.text = "\(album.photos.count) Pictures"
        } else {
            numberOfPhotosLabel.isHidden = true
        }
        
        self.albumPhotoImageView.setImageBy(url: album.photos[0].url, contentMode: .scaleAspectFill, placeholderImageName: "placeholder")
        albumPhotoImageView.layer.cornerRadius = 20
        albumPhotoOpacityView.layer.cornerRadius = 20
    }
}
