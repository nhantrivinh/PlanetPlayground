import UIKit

public class RocketView: UIView {
    
    private var _flameAlpha: CGFloat = 1.0
    private var _flameHeight: CGFloat = 1.0
    
    public var flameAlpha: CGFloat {
        set (newAlpha) {
            _flameAlpha = newAlpha
            setNeedsDisplay()
        } get {
            return _flameAlpha
        }
    }
    
    public var flameHeight: CGFloat {
        set (newHeight) {
            _flameHeight = newHeight
            setNeedsDisplay()
        } get {
            return _flameHeight
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        IntroStyleKit.drawRocketWithFlame(frame: bounds, resizing: .stretch, flameAlpha: flameAlpha, flameScaleInHeight: flameHeight)
    }
}

public class PlanetView: UIView {
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        IntroStyleKit.drawPlanetPlayground(frame: bounds, resizing: .stretch)
    }
}
