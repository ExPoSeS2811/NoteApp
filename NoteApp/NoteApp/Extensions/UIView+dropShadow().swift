import UIKit

extension UIView {
    func dropShadow(color: UIColor = .black) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5
        
        self.layer.shouldRasterize = true
    }
}
