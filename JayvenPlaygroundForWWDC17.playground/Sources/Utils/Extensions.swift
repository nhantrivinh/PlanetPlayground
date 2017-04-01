import UIKit

public extension UIView {
    
    func fadeAndAway() {
        self.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 1
        }) { (complete) in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
                self.alpha = 0
            }, completion: nil)
        }
    }
    
    func fadeIn() {
        self.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 1
        }, completion: nil)
    }
    
    func fadeOut() {
        self.alpha = 1
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 0
        }, completion: nil)
    }
}
