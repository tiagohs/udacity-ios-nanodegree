//
//  HomeController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

// MARK: HomeController
class HomeController: BaseController {
    
    let MovieHomeSegueIdentifier = "MovieHomeSegueIdentifier"
    
    let GenresCollectionViewIdentifier = "GenresCollectionViewIdentifier"
    let MoviesCollectionViewIdentifier = "MoviesCollectionViewIdentifier"
    
    let GenresCellIdentifier = "GenresCellIdentifier"
    let MoviesCellIdentifier = "MoviesCellIdentifier"
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var genresCollectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            genresCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    @IBOutlet weak var moviesCollectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            moviesCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var genres: [Genre]?
    var movies: [Movie]?
    
    var presenter: HomePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionViews()
        
        self.presenter = HomePresenter()
        self.presenter.onInit(view: self)
        self.presenter.fetchGenres()
        self.showActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupDarkNavigationBar()
    }
    
    private func setupCollectionViews() {
        let genreCellNib = UINib(nibName: "GenreCell", bundle: nil)
        let moviesCellNib = UINib(nibName: "MovieCell", bundle: nil)
        
        self.genresCollectionView.register(genreCellNib, forCellWithReuseIdentifier: GenresCellIdentifier)
        self.moviesCollectionView.register(moviesCellNib, forCellWithReuseIdentifier: MoviesCellIdentifier)
        
        self.genresCollectionView.hero.modifiers = [.cascade]
        self.moviesCollectionView.hero.modifiers = [.cascade]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movie = sender as? Movie, let destination = segue.destination as? MovieDetailController {
            destination.movie = movie
        }
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let restorationIdentifier = collectionView.restorationIdentifier
        
        switch restorationIdentifier {
        case GenresCollectionViewIdentifier:
            return genres?.count ?? 0
        case MoviesCollectionViewIdentifier:
            return movies?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let restorationIdentifier = collectionView.restorationIdentifier
        
        switch restorationIdentifier {
        case GenresCollectionViewIdentifier:
            let cell = self.bindGenresCell(collectionView, cellForItemAt: indexPath)
            cell.hero.modifiers = [.fade, .scale(0.5)]
            
            return cell
        case MoviesCollectionViewIdentifier:
            let cell = self.bindMoviesCell(collectionView, cellForItemAt: indexPath)
            cell.hero.modifiers = [.fade, .scale(0.5)]
            
            return cell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let restorationIdentifier = collectionView.restorationIdentifier
        
        switch restorationIdentifier {
        case GenresCollectionViewIdentifier:
            if let genres = self.genres {
                let selectedGenre = genres[indexPath.row]
                
                let newGenres = genres.map({ (genre) -> Genre in
                    genre.isSelected = selectedGenre.id == genre.id
                    
                    return genre
                })
                
                self.genres = newGenres
                self.genresCollectionView.reloadData()
                
                self.presenter.fetchMoviesByGenre(genre: selectedGenre)
                self.showActivityIndicator()
            }
        case MoviesCollectionViewIdentifier:
            if let movies = self.movies {
                let movie = movies[indexPath.row]
                
                performSegue(withIdentifier: MovieHomeSegueIdentifier, sender: movie)
            }
        default:
            return
        }
        
    }
    
}

// MARK: HomeViewInterface

extension HomeController: HomeViewInterface {
    
    func bindMovies(movies: [Movie]) {
        self.movies = movies
        
        performUIUpdatesOnMain {
            self.moviesCollectionView.reloadData()
            self.hideActivityIndicator()
        }
    }
    
    func bindGenres(genres: [Genre]) {
        self.genres = genres
        
        performUIUpdatesOnMain {
            self.genresCollectionView.reloadData()
        }
        
        self.presenter.fetchPopularMovies()
    }
    
}
