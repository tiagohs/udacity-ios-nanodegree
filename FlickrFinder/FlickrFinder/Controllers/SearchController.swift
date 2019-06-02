//
//  SearchController.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit


// MARK: SearchController

class SearchController: BaseController {
    
    let ResultCollectionViewIdentifier              = "ResultCollectionViewIdentifier"
    let SearchSegueIdentifier                       = "SearchSegueIdentifier"
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    @IBOutlet weak var resultsCollectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            resultsCollectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var photosResult: Photos?                       = nil
    
    private var presenter: SearchPresenterInterface!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupResultsCollectionView()
        
        self.presenter = SearchPresenter()
        self.presenter.onInit(view: self)
    }
    
    private func setupResultsCollectionView() {
        let cellNib = UINib(nibName: "PhotoCell", bundle: nil)
        
        self.resultsCollectionView.register(cellNib, forCellWithReuseIdentifier: ResultCollectionViewIdentifier)
    }
    
    // MARK: View Actions
    
    @IBAction func searchClicked(_ sender: Any) {
        if let searchText = self.searchTextField.text {
            self.presenter.searchByPhrase(phrase: searchText)
            self.showActivityIndicator()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photo = sender as? Photo, let destination = segue.destination as? PhotoDetailViewController {
            destination.photo = photo
        }
    }
}

// MARK: SearchViewInterface

extension SearchController: SearchViewInterface {
    
    func onBindPhotos(photos: Photos) {
        self.photosResult = photos
        
        performUIUpdatesOnMain {
            self.resultsCollectionView.reloadData()
            self.hideActivityIndicator()
        }
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosResult?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        if let photos = self.photosResult {
            let photo = photos.photos[indexPath.row]
            cell.photo = photo
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photos = self.photosResult {
            let photo = photos.photos[indexPath.row]
            performSegue(withIdentifier: SearchSegueIdentifier, sender: photo)
        }
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension SearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: UIScreen.main.bounds.width, height: collectionViewSize / 2)
    }
}
