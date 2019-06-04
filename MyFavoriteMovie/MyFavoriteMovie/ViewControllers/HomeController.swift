//
//  HomeController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: HomeController
class HomeController: BaseController {
    
    let GenresCellIdentifier = "GenresCellIdentifier"
    let MoviesCellIdentifier = "GenresCellIdentifier"
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var genres: [Genre]?
    var movies: [Movie]?
    
    var presenter: HomePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = HomePresenter()
        self.presenter.onInit(view: self)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return genres?.count ?? 0
        case 1:
            return movies?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            return self.bindGenresCell(collectionView, cellForItemAt: indexPath)
        case 1:
            return self.bindMoviesCell(collectionView, cellForItemAt: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
    
    private func bindGenresCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let genres = self.genres, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresCellIdentifier, for: indexPath) as? GenreCell {
            cell.genre = genres[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    private func bindMoviesCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let movies = self.movies, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCellIdentifier, for: indexPath) as? MovieCell {
            cell.genres = self.genres
            cell.movie = movies[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: HomeViewInterface

extension HomeController: HomeViewInterface {
    
    func bindMovies(movies: [Movie]) {
        self.movies = movies
        
        self.moviesCollectionView.reloadData()
    }
    
    func bindGenres(genres: [Genre]) {
        self.genres = genres
        
        self.genresCollectionView.reloadData()
    }
    
}
