import Foundation
import Kingfisher



struct ImageLoader {
    
    
    func loadImage (with endpoint: String?, image: UIImageView) {
        if let endpoint = endpoint {
            let url = URL(string: endpoint)
            image.kf.setImage(with: url, placeholder: UIImage(named: "movie"))
        }
    }
}
