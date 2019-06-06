//
//  WatchlistController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 06/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit
import Hero

class WatchlistController: BaseController {
    let MoviesSegueIdentifier = "MoviesSegueIdentifier"
    let MoviesCellIdentifier = "MoviesCellIdentifier"
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            moviesCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var presenter: WatchlistPresenterInterface?
    var movies: [Movie]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupCollectionView()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if (self.presenter == nil) {
            self.presenter = WatchlistPresenter()
            self.presenter?.onInit(view: self, appDelegate: appDelegate)
        }
        
        self.presenter?.fetchWatchlist()
        
        super.viewWillAppear(animated)
    }
    
    private func setupCollectionView() {
        let moviesCellNib = UINib(nibName: "MovieCell", bundle: nil)
        
        self.moviesCollectionView.register(moviesCellNib, forCellWithReuseIdentifier: MoviesCellIdentifier)
        self.moviesCollectionView.hero.modifiers = [.cascade]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let movie = sender as? Movie, let destination = segue.destination as? MovieDetailController {
            destination.movie = movie
        }
    }
}

extension WatchlistController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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

extension WatchlistController: WatchlistViewInterface {
    
    func bindMovies(movies: [Movie]) {
        self.movies = movies
        
        performUIUpdatesOnMain {
            self.moviesCollectionView.reloadData()
        }
        
    }
}
