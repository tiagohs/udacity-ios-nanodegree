//
//  HomeController.swift
//  FlickrFinder
//
//  Created by Tiago Silva on 22/05/2019.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

// MARK: HomeController

class HomeController: BaseController {
    
    let RecentAlbumsIdentifier                  = "RecentAlbumsIdentifier"
    let PhotoDetailSegueIdentifier              = "PhotoDetailSegueIdentifier"
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var presenter: HomePresenterInterface?
    
    var photos: Photos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecentPhotosCollectionView()
        
        self.presenter = HomePresenter()
        self.presenter?.onInit(view: self)
        
        self.presenter?.fetchRecentPhotos()
        self.showActivityIndicator()
    }
    
    private func setupRecentPhotosCollectionView() {
        let cellNib = UINib(nibName: "PhotoCell", bundle: nil)
        
        self.photosCollectionView.register(cellNib, forCellWithReuseIdentifier: RecentAlbumsIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photo = sender as? Photo, let destination = segue.destination as? PhotoDetailViewController {
            destination.photo = photo
        }
    }
}

// MARK: HomeViewInterface

extension HomeController: HomeViewInterface {
    
    func bindRecentPhotos(photos: Photos) {
        self.photos = photos
        
        performUIUpdatesOnMain {
            self.photosCollectionView.reloadData()
            self.hideActivityIndicator()
        }
        
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentAlbumsIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        if let photos = self.photos {
            let photo = photos.photos[indexPath.row]
            cell.photo = photo
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photos = self.photos {
            let photo = photos.photos[indexPath.row]
            performSegue(withIdentifier: PhotoDetailSegueIdentifier, sender: photo)
        }
    }
}


// MARK: UICollectionViewDelegateFlowLayout

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
}
