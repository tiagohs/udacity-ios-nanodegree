
import UIKit
import Hero

class PhotoCell: UIBaseResponsiveCollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo? {
        didSet { bindPhoto(photo: photo!) }
    }
    
    // MARK: View Setups
    
    private func setupPhotoImageView() {
        photoImageView.layer.cornerRadius = 10
    }
    
    // MARK: Bind Photo Data
    
    private func bindPhoto(photo: Photo) {
        setupPhotoImageView()
        
        self.photoImageView.hero.id = photo.id
        self.photoImageView.setImageBy(url: photo.url, contentMode: .scaleAspectFill, placeholderImageName: "placeholder")
    }
    
}
