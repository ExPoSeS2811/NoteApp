import UIKit

extension UIView {
    func rounded(radius: CGFloat = 15) {
        self.layer.cornerRadius = radius
        self.layer.cornerCurve = .continuous
    }
}
