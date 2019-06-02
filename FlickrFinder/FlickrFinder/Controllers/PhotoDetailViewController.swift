
import UIKit
import Hero

class PhotoDetailViewController: BaseController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photo = self.photo {
            photoImageView.hero.id = photo.id
            photoImageView.setImageBy(url: photo.url, contentMode: .scaleAspectFit, placeholderImageName: "placeholder")
        }
    }
    
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let progress = translation.y / 2 / view.bounds.height
        
        switch sender.state {
        case .began:
            hero.dismissViewController()
        case .changed:
            
            Hero.shared.update(progress)
            
            let currentPos = CGPoint(x: translation.x + photoImageView.center.x, y: translation.y + photoImageView.center.y)
            
            Hero.shared.apply(modifiers: [.position(currentPos)], to: photoImageView)
        default:
            if progress + sender.velocity(in: nil).y / view.bounds.height > 0.2 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
}
