//
//  MovieDetailsCell.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 05/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailsCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var onMovieCellListener: OnMovieCellListener?
    var genres: [Genre]?
    var movie: Movie? {
        didSet { bindMovie(self.movie!) }
    }
    
    func bindMovie(_ movie: Movie) {
        setupFavoriteButton(movie.isFavorite)
        
        titleLabel.text = movie.title
        yearLabel.text = ViewUtils.dateFrom(string: movie.releaseDate)?.year
        genresLabel.text = TMDBUtils.formatGenresToStringFrom(arrayOfGenresID: movie.genreIds, genres: self.genres)
        overviewLabel.text = movie.overview
        
        posterImage.setTMDBImageBy(url: movie.posterPath, contentSize: Constants.TMDB.ImageSize.POSTER.w342, placeholder: Constants.Assets.MoviePlaceholder)
        backdropImage.setTMDBImageBy(url: movie.backdropPath, contentSize: Constants.TMDB.ImageSize.BACKDROP.w780, placeholder: Constants.Assets.BackdropPlaceholder)
    }
    
    private func setupFavoriteButton(_ isFavorite: Bool) {
        favoriteButton.layer.cornerRadius = favoriteButton.bounds.width / 2
        
        let imageName = isFavorite ? Constants.Assets.HeartFilled : Constants.Assets.HeartOutline
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
        favoriteButton.imageView?.setImageColorBy(uiColor: UIColor.red)
    }
    
    @IBAction func favoriteClicked(_ sender: Any) {
        let isFavorite = self.movie != nil ? !self.movie!.isFavorite : false
        
        onMovieCellListener?.onFavoriteClicked(isFavorite)
    }
    
}

protocol OnMovieCellListener {
    
    func onFavoriteClicked(_ isFavorite: Bool)
}
