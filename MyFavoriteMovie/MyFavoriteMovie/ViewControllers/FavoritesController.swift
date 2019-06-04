//
//  FavoritesController.swift
//  MyFavoriteMovie
//
//  Created by Tiago Silva on 02/06/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class FavoritesController: BaseTableController {
    
    var presenter: FavoritesPresenterInterface?
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = FavoritesPresenter()
        self.presenter?.onInit(view: self)
    }
}

extension FavoritesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension FavoritesController: FavoritesViewInterface {
    
    func bindMovies(movies: [Movie]) {
        self.movies = movies
        
        self.tableView.reloadData()
    }
}
