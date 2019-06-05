//
//  MovieDetailController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailController: BaseTableController {
    
    let MovieDetailsCellIdentifier = "MovieDetailsCellIdentifier"
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    var movie: Movie?
    var genres: [Genre]?
    var presenter: MovieDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.presenter = MovieDetailPresenter()
        self.presenter.onInit(view: self, appDelegate: appDelegate)
        
        if let movie = self.movie {
            self.presenter.checkMovieState(movie: movie)
            self.showActivityIndicator()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTransparentLightNavigationBar() 
    }
    
}

extension MovieDetailController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let movie = self.movie, let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCellIdentifier, for: indexPath) as? MovieDetailsCell {
            cell.genres = self.genres
            cell.movie = movie
            cell.onMovieCellListener = self
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension MovieDetailController: OnMovieCellListener {
    
    func onFavoriteClicked(_ isFavorite: Bool) {
        self.showActivityIndicator()
        
        if let movie = self.movie {
            self.presenter.markAsFavorite(movie, isFavorite)
        }
    }
    
}

extension MovieDetailController: MovieDetailViewInterface {
    
    func bindMovie(movie: Movie) {
        self.movie = movie
        
        performUIUpdatesOnMain {
            self.hideActivityIndicator()
            self.tableView.reloadData()
        }
    }
    
    func updateFavoriteButton(_ isFavorite: Bool) {
        self.movie?.isFavorite = isFavorite
        
        performUIUpdatesOnMain {
            self.hideActivityIndicator()
            self.tableView.reloadData()
        }
    }
}
