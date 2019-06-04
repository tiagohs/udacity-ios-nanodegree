//
//  GenreCell.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    @IBOutlet weak var genreButton: UIButton!
    
    var genre: Genre? {
        didSet { bindGenre(self.genre!) }
    }
    
    private func bindGenre(_ genre: Genre) {
        genreButton.setTitle(genre.name, for: .normal)
    }
}
