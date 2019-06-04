//
//  MovieDetailController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class MovieDetailController: BaseTableController {
    
    var movie: Movie?
    var presenter: MovieDetailPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        self.presenter = MovieDetailPresenter()
        self.presenter.onInit(view: self, appDelegate: appDelegate)
        
        if let movie = self.movie {
            self.presenter.checkMovieState(movie: movie)
        }
    }
}

extension MovieDetailController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension MovieDetailController: MovieDetailViewInterface {
    
    func bindMovie(movie: Movie) {
        //
    }
}
