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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    var genre: Genre? {
        didSet { bindGenre(self.genre!) }
    }
    
    private func bindGenre(_ genre: Genre) {
        genreButton.setTitle(genre.name, for: .normal)
        
        setState(genre.isSelected)
    }
    
    func setState(_ isSelected: Bool) {
        if isSelected {
            genreButton.backgroundColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
            genreButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            genreButton.backgroundColor = UIColor.white
            genreButton.setTitleColor(ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary), for: .normal)
        }
    }
}
