//
//  FavoritesController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class FavoritesController: BaseController {
    
    let MovieFavoriteSegueIdentifier = "MovieFavoriteSegueIdentifier"
    let MoviesCellIdentifier = "MoviesCellIdentifier"
    
    @IBOutlet weak var favoriteMoviesCollectionView: UICollectionView!
    @IBOutlet weak var favoriteMoviesCollectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            favoriteMoviesCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var presenter: FavoritesPresenterInterface?
    var movies: [Movie]?
    
    override func viewWillAppear(_ animated: Bool) {
        
        //self.setupDarkNavigationBar()
        self.setupCollectionView()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if (self.presenter == nil) {
            self.presenter = FavoritesPresenter()
            self.presenter?.onInit(view: self, appDelegate: appDelegate)
        }
        
        self.presenter?.fetchFavoriteMovies()
        
        super.viewWillAppear(animated)
    }
    private func setupCollectionView() {
        let moviesCellNib = UINib(nibName: "MovieCell", bundle: nil)
        
        self.favoriteMoviesCollectionView.register(moviesCellNib, forCellWithReuseIdentifier: MoviesCellIdentifier)
        self.favoriteMoviesCollectionView.hero.modifiers = [.cascade]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movie = sender as? Movie, let destination = segue.destination as? MovieDetailController {
            destination.movie = movie
        }
    }
}

extension FavoritesController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let movies = self.movies, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCellIdentifier, for: indexPath) as? MovieCell {
            cell.movie = movies[indexPath.row]
            cell.hero.modifiers = [.fade, .scale(0.5)]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movies = self.movies {
            let movie = movies[indexPath.row]
            
            if let controller = self.storyboard!.instantiateViewController(withIdentifier: "MovieDetailsIdentifier") as? MovieDetailController {
                controller.hero.modalAnimationType = .slide(direction: .left)
                controller.movie = movie
                
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}

extension FavoritesController: FavoritesViewInterface {
    
    func bindMovies(movies: [Movie]) {
        self.movies = movies
        
        performUIUpdatesOnMain {
            self.favoriteMoviesCollectionView.reloadData()
        }
        
    }
}
