//
//  MovieDetailController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailController: BaseController {
    
    let MovieDetailsCellIdentifier = "MovieDetailsCellIdentifier"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToWatchlistButton: UIButton!
    
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
    
    @IBAction func addToWatchlistClicked(_ sender: Any) {
        
        if let movie = self.movie {
            let addToWatchlist = !movie.addedToWatchlist
            
            self.presenter.addToWatchlist(movie, addToWatchlist)
        }
        
    }
}

extension MovieDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    func updateAddToWatchlistButton(_ addedToWatchlist: Bool) {
        
        performUIUpdatesOnMain {
            if self.addToWatchlistButton.isHidden { self.addToWatchlistButton.isHidden = false }
            
            if (addedToWatchlist) {
                self.addToWatchlistButton.setTitle("Remove from Watchlist", for: .normal)
                self.addToWatchlistButton.setTitleColor(ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary), for: .normal)
                self.addToWatchlistButton.backgroundColor = UIColor.white
            } else {
                self.addToWatchlistButton.setTitle("Add to Watchlist", for: .normal)
                self.addToWatchlistButton.setTitleColor(UIColor.white, for: .normal)
                self.addToWatchlistButton.backgroundColor = ViewUtils.UIColorFromHEX(hex: Constants.COLOR.colorPrimary)
            }
        }
    }
}
