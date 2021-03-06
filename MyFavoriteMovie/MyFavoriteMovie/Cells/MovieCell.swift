//
//  MovieCell.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 03/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var movie: Movie? {
        didSet { bindMovie(self.movie!) }
    }
    var genres: [Genre]?
    
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
    
    private func bindMovie(_ movie: Movie) {
        self.posterImage.hero.id = String(describing: movie.id)
        
        titleLabel.text = movie.title
        yearLabel.text = ViewUtils.dateFrom(string: movie.releaseDate)?.year
        genresLabel.text = TMDBUtils.formatGenresToStringFrom(arrayOfGenresID: movie.genreIds, genres: self.genres)
        
        posterImage.setTMDBImageBy(url: movie.posterPath, contentSize: Constants.TMDB.ImageSize.POSTER.w342, placeholder: Constants.Assets.MoviePlaceholder)
    }
}
