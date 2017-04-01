import UIKit
import PlaygroundSupport

public class IntroViewController: UIViewController {
    
    var margins = UILayoutGuide()
    public var aboutMeVC = UIViewController()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello there"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = .darkGray
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.text = "Fasten your seat belt."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "TAP ANYWHERE TO LAUNCH INTO SPACE WITH ME"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let rocketView: RocketView = {
        var rocket = RocketView()
        rocket.translatesAutoresizingMaskIntoConstraints = false
        rocket.backgroundColor = .clear
        rocket.alpha = 0
        return rocket
    }()
    
    var planetView: PlanetView = {
        var planet = PlanetView()
        planet.translatesAutoresizingMaskIntoConstraints = false
        planet.backgroundColor = .clear
        planet.alpha = 0
        return planet
    }()
    
    override public func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .white
    }
    
    override public func viewDidLoad() {
        margins = view.layoutMarginsGuide
        setupViews()
        animate()
    }
    
    func setupViews() {
        view.addSubview(mainLabel)
        view.addSubview(subLabel)
        view.addSubview(instructionLabel)
        
        mainLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        mainLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: -100).isActive = true
        
        subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 8).isActive = true
        subLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        subLabel.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
        
        instructionLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -12).isActive = true
        instructionLabel.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true
        instructionLabel.rightAnchor.constraint(equalTo: margins.rightAnchor).isActive = true
    }
    
    func animate() {
        let when = DispatchTime.now() + 2
        mainLabel.fadeIn()
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.subLabel.fadeAndAway()
            let when = DispatchTime.now() + 3.3
            DispatchQueue.main.asyncAfter(deadline: when, execute: {
                self.subLabel.fadeIn()
                self.subLabel.text = "Prepare for launch off."
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when, execute: {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IntroViewController.beginAdventure))
                    self.view.addGestureRecognizer(tapGesture)
                    self.instructionLabel.fadeIn()
                })
            })
        }
    }
    
    func beginAdventure() {
        let when = DispatchTime.now() + 1
        mainLabel.fadeOut()
        subLabel.fadeOut()
        instructionLabel.fadeOut()
        view.gestureRecognizers?.removeAll()
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.mainLabel.removeFromSuperview()
            self.subLabel.removeFromSuperview()
            self.instructionLabel.removeFromSuperview()
            self.setupViews2()
        }
    }
    
    func setupViews2() {
        view.addSubview(rocketView)
        rocketView.heightAnchor.constraint(equalToConstant: 181).isActive = true
        rocketView.widthAnchor.constraint(equalToConstant: 81).isActive = true
        rocketView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        rocketView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 181).isActive = true
        
        self.rocketLaunch()
    }
    
    func rocketLaunch() {
        //animate bg
        self.rocketView.alpha = 1
        UIView.animate(withDuration: 3, animations: {
            self.view.backgroundColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.00)
        }) { (complete) in
            self.rocketMove()
        }
    }
    
    var setupViews2Count = 1
    
    func rocketMove() {
        UIView.animate(withDuration: 2, animations: {
            self.rocketView.frame.origin.y -= (self.rocketView.frame.height + 30)
            self.rocketView.flameAlpha = 0
        }) { (complete) in
            
            UIView.animate(withDuration: 2, animations: {
                self.rocketView.flameAlpha = 1
                self.rocketView.frame.origin.y -= (self.view.bounds.height + (self.rocketView.frame.height))
            }, completion: { (complete) in
                self.setupViews3()
            })
        }
        
    }
    
    var planetViewHeightConstraint: NSLayoutConstraint!
    var planetViewWidthConstraint: NSLayoutConstraint!
    
    func setupViews3() {
        rocketView.removeFromSuperview()
        view.addSubview(planetView)
        view.addSubview(rocketView)
        
        rocketView.heightAnchor.constraint(equalToConstant: 181).isActive = true
        rocketView.widthAnchor.constraint(equalToConstant: 81).isActive = true
        rocketView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        rocketView.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 300).isActive = true
        rocketView.alpha = 1
        
        planetViewHeightConstraint = planetView.heightAnchor.constraint(equalToConstant: 160)
        planetViewWidthConstraint = planetView.widthAnchor.constraint(equalToConstant: 160)
        
        planetViewWidthConstraint.isActive = true
        planetViewHeightConstraint.isActive = true
        
        planetView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        planetView.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0).isActive = true
        
        setupViews3Scene1()
    }
    
    
    func setupViews3Scene1() {
        self.rocketView.alpha = 0
        UIView.animate(withDuration: 3, animations: {
            self.planetView.alpha = 1
            self.rocketView.alpha = 1
        }) { (complete) in
            UIView.animate(withDuration: 3, animations: {
                self.planetViewHeightConstraint.constant *= 3
                self.planetViewWidthConstraint.constant *= 3
                self.planetView.setNeedsDisplay()
                self.view.layoutIfNeeded()
            }, completion: { (_) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.rocketView.frame.origin.y -= 180
                }, completion: { (_) in
                    self.rocketView.flameAlpha = 0
                    UIView.animate(withDuration: 2, animations: {
                        self.rocketView.alpha = 0
                    }, completion: { (_) in
                        UIView.animate(withDuration: 2, animations: {
                            self.planetView.alpha = 0
                        }, completion: { (_) in
                            //Self Introduction
                            self.presentAboutMeVC()
                        })
                    })
                })
                
            })
            
        }
    }
    
    func presentAboutMeVC() {
        PlaygroundPage.current.liveView = aboutMeVC
    }
}
