//
//  SearchController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 10/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class SearchController: BaseController {
    let MovieDetailsIdentifier = "MovieDetailsIdentifier"
    let MoviesCellIdentifier = "MoviesCellIdentifier"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            moviesCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var searchController: UISearchController!
    var presenter: SearchPresenterInterface?
    var movies: [Movie]?
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = SearchPresenter()
        self.presenter?.onInit(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        let moviesCellNib = UINib(nibName: "MovieCell", bundle: nil)
        
        self.moviesCollectionView.register(moviesCellNib, forCellWithReuseIdentifier: MoviesCellIdentifier)
        self.moviesCollectionView.hero.modifiers = [.cascade]
    }
    
}

extension SearchController: SearchViewInterface {
    
    func bindMovies(movies: [Movie]) {
        self.movies = movies
        
        if self.movies?.isEmpty ?? true {
            searchActive = false
        } else {
            searchActive = true
        }
        
        performUIUpdatesOnMain {
            self.moviesCollectionView.reloadData()
        }
    }
    
}

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
            
            if let controller = self.storyboard!.instantiateViewController(withIdentifier: MovieDetailsIdentifier) as? MovieDetailController {
                controller.hero.modalAnimationType = .slide(direction: .left)
                controller.movie = movie
                
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}

extension SearchController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
        if self.searchBarIsEmpty(searchBar.text) {
            self.bindMovies(movies: [])
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
        self.bindMovies(movies: [])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
        if self.searchBarIsEmpty(searchBar.text) {
            self.bindMovies(movies: [])
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchBarIsEmpty(searchBar.text) {
            self.bindMovies(movies: [])
            return
        }
        
        self.presenter?.searchMovieBy(query: searchText)
    }
    
    func searchBarIsEmpty(_ text: String?) -> Bool {
        return text?.isEmpty ?? true
    }
    
}
