
import UIKit
import AlamofireImage

class GalleryImageVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var zoomImageView: UIImageView!
    // MARK: - Properties
    var imgStr = ""
    var zoomedImage = UIImage()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: .black, isImage: true)
        self.navigationController?.isNavigationBarHidden = false
       // configureNavigationBar()
        zoomImageView.image = zoomedImage
    }
}
// MARK: - Actions For Buttons
extension GalleryImageVC {
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    // Mark: - Zoom Image Action
    @IBAction func scaleImage(_ sender: UIPinchGestureRecognizer) {
        zoomImageView.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    func configureNavigationBar() {
        self.setNavigationBarImage(for: UIImage(), color: .clear)
    }
}
