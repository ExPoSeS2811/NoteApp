import UIKit

extension UIView {
    func addGradient(_ colors: [UIColor] = [UIColor.red, UIColor.yellow, UIColor.blue]) {
        let gradient = CAGradientLayer()
        
        gradient.colors = colors.map { $0.cgColor }
        gradient.opacity = 0.6
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
