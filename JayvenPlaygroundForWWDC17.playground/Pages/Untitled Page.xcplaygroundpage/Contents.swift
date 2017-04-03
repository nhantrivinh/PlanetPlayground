//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import AVFoundation

public let coolBlue = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.00)


public class IntroViewController: UIViewController {
    
    var margins = UILayoutGuide()
    
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
        label.text = "Fasten your seatbelt."
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
//        view = UIView(frame: UIScreen.main.bounds)
        let frame = CGRect(x: 0, y: 0, width: 500, height: 500)
        view = UIView(frame: frame)
        view.backgroundColor = .white
    }
    
    // START:
    override public func viewDidLoad() {
        margins = view.layoutMarginsGuide
        setupViews()
//        showMenu()
    }
    
    func setupViews() {
        view.subviews.forEach({ $0.removeFromSuperview() })
        
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
        
        animate()
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
            self.speak(text: "Welcome aboard friend! This is your captain speaking. I hope that you will have a great flight to Planet Playground. The weather is looking really great today. Make sure to stay hydrated as always and enjoy the ride!")
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
                UIView.animate(withDuration: 1, animations: {
                    self.rocketView.frame.origin.y -= 180
                }, completion: { (_) in
                    self.rocketView.flameAlpha = 0
                    UIView.animate(withDuration: 2, animations: {
                        self.rocketView.alpha = 0
                    }, completion: { (_) in
                        self.presentAboutMeVC()
                        UIView.animate(withDuration: 1.5, animations: {
//                            effectView.effect = UIBlurEffect(style: .light)
//                            self.planetView.alpha = 0
                            
                        }, completion: { (_) in
                            //Self Introduction
//                            self.presentAboutMeVC()
                        })
                    })
                })
                
            })
            
        }
    }
    
    
    func presentAboutMeVC() {
        //        PlaygroundPage.current.liveView = aboutMeVC
        let effectView = UIVisualEffectView()
        effectView.frame = UIScreen.main.bounds
        view.addSubview(effectView)
        
        UIView.animate(withDuration: 1, animations: {
            effectView.effect = UIBlurEffect(style: .light)
        }, completion: { _ in
//            self.repeatIntro()
            self.showMenu()
        })
        
    }
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Warm welcome from my planet."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 42)
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alpha = 0
        return sv
    }()
    
    let btnForMenu: UIButton = {
        let btn = UIButton()
        btn.setTitle("PASSION", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        let width: CGFloat = 300
        let height: CGFloat = 150
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightMedium)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    let effectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.frame = UIScreen.main.bounds
        return view
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 45
        slider.minimumValue = 0
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isUserInteractionEnabled = true
        slider.isContinuous = true
        slider.alpha = 0
        slider.addTarget(self, action: #selector(introVC.sliderValueChanged), for: .valueChanged)
        return slider
    }()
    
    func sliderValueChanged(sender: UISlider) {
        let x = CGFloat(round(slider.value))
        buffDude.rotation = x
    }
    
    //WORK1
    
    func btnForMenuTapped(_ sender: UITapGestureRecognizer) {
        
        view.addSubview(effectView)
        view.addSubview(buffDude)
        view.addSubview(subLabelTraining)
        view.addSubview(mainLabelTraining)
        view.addSubview(slider)

        buffDude.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        buffDude.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0).isActive = true
        buffDude.heightAnchor.constraint(equalToConstant: 180 * 1.5).isActive = true
        buffDude.widthAnchor.constraint(equalToConstant: 220 * 1.5).isActive = true
        
        subLabelTraining.bottomAnchor.constraint(equalTo: buffDude.topAnchor, constant: -16).isActive = true
        subLabelTraining.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 8).isActive = true
        subLabelTraining.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 8).isActive = true
        
        mainLabelTraining.bottomAnchor.constraint(equalTo: subLabelTraining.topAnchor, constant: -8).isActive = true
        mainLabelTraining.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 8).isActive = true
        mainLabelTraining.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 8).isActive = true
        
        slider.topAnchor.constraint(equalTo: buffDude.bottomAnchor, constant: 16).isActive = true
        slider.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        slider.widthAnchor.constraint(equalTo: buffDude.widthAnchor, constant: 0).isActive = true
        
        mainLabelTraining.fadeIn()
        subLabelTraining.fadeIn()
        buffDude.fadeIn()
        slider.fadeIn()
        
        UIView.animate(withDuration: 1, animations: {
            self.effectView.effect = UIBlurEffect(style: .dark)
            
        }) { (_) in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IntroViewController.btnForMenuOnReturn))
            self.view.addGestureRecognizer(tapGesture)
        }
        
    }
    
    
    func btnForMenuOnReturn() {
        view.gestureRecognizers?.removeAll()
        mainLabelTraining.fadeOut()
        subLabelTraining.fadeOut()
        buffDude.fadeOut()
        slider.fadeOut()
        
        UIView.animate(withDuration: 1, animations: {
            self.effectView.effect = nil
            
        }) { (_) in
            self.effectView.removeFromSuperview()
            self.buffDude.removeFromSuperview()
            self.subLabelTraining.removeFromSuperview()
            self.mainLabelTraining.removeFromSuperview()
            self.slider.removeFromSuperview()
        }
    }
    
    
    
    let btnForMenu2: UIButton = {
        let btn = UIButton()
        btn.setTitle("SHARING", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        let width: CGFloat = 300
        let height: CGFloat = 150
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightMedium)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    
    // WORK2
    func btnForMenu2Tapped(_ sender: UIButton) {
        view.addSubview(effectView)
        
        self.dropArticle()
        
        view.addSubview(yellowStar)
        view.addSubview(subLabelSharing)
        view.addSubview(mainLabelSharing)
        
        yellowStar.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        yellowStar.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0).isActive = true
        yellowStar.heightAnchor.constraint(equalToConstant: 113 * 1.5).isActive = true
        yellowStar.widthAnchor.constraint(equalToConstant: 113 * 1.5).isActive = true
        
        subLabelSharing.bottomAnchor.constraint(equalTo: yellowStar.topAnchor, constant: -16).isActive = true
        subLabelSharing.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 8).isActive = true
        subLabelSharing.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 8).isActive = true
        
        mainLabelSharing.bottomAnchor.constraint(equalTo: subLabelSharing.topAnchor, constant: -8).isActive = true
        mainLabelSharing.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 8).isActive = true
        mainLabelSharing.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 8).isActive = true

        
        mainLabelSharing.fadeIn()
        subLabelSharing.fadeIn()
        yellowStar.fadeIn()
        
        
        UIView.animate(withDuration: 1, animations: {
            self.effectView.effect = UIBlurEffect(style: .dark)
        }) { (_) in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IntroViewController.btnForMenu2OnReturn))
            self.view.addGestureRecognizer(tapGesture)
        }
    }
    
    var article1: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let image = UIImage(named: "article1.png")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 1
        return imageView
    }()
    
    var sampleView: UIView = {
        let theView = UIView()
        theView.backgroundColor = .black
        theView.translatesAutoresizingMaskIntoConstraints = false
        return theView
    }()
    
    
    
    var animator: UIDynamicAnimator?
    
    func dropArticle() {
//        let item = article1
        let items = [article1]
        view.addSubview(article1)
        article1.fadeIn()
        article1.frame.size = CGSize(width: 265, height: 182)
        article1.frame.origin.x = view.bounds.midX - article1.frame.size.width/2
        
        animator = UIDynamicAnimator(referenceView:view)
        let gravity = UIGravityBehavior(items: items)
        let vector = CGVector(dx: 0.0, dy: 0.5)
        gravity.gravityDirection = vector
        
        let collision = UICollisionBehavior(items: items)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        
        let behavior = UIDynamicItemBehavior(items: items)
        behavior.elasticity = 0.5
//
        animator?.addBehavior(gravity)
        animator?.addBehavior(collision)
        animator?.addBehavior(behavior)
    }
    
    func btnForMenu2OnReturn() {
        view.gestureRecognizers?.removeAll()
        mainLabelSharing.fadeOut()
        subLabelSharing.fadeOut()
        yellowStar.fadeOut()
        article1.fadeOut()
        
        UIView.animate(withDuration: 1, animations: {
            self.effectView.effect = nil
            
        }) { (_) in
            self.effectView.removeFromSuperview()
            self.yellowStar.removeFromSuperview()
            self.subLabelSharing.removeFromSuperview()
            self.mainLabelSharing.removeFromSuperview()
            self.article1.removeFromSuperview()
            self.animator?.removeAllBehaviors()
        }
    }
    
    let btnForMenu3: UIButton = {
        let btn = UIButton()
        btn.setTitle("WWDC17", for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        let width: CGFloat = 300
        let height: CGFloat = 150
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: UIFontWeightMedium)
        return btn
    }()
    
    // WORK3
    func btnForMenu3Tapped(_ sender: UITapGestureRecognizer) {
        
        view.addSubview(effectView)
        view.addSubview(planetViewSharing)
        view.addSubview(subLabelWWDC)
        view.addSubview(mainLabelWWDC)
        
        planetViewSharing.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        planetViewSharing.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
        planetViewSharing.heightAnchor.constraint(equalToConstant: 280).isActive = true
        planetViewSharing.widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        subLabelWWDC.bottomAnchor.constraint(equalTo: planetViewSharing.topAnchor, constant: -16).isActive = true
        subLabelWWDC.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 8).isActive = true
        subLabelWWDC.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 8).isActive = true
        
        mainLabelWWDC.bottomAnchor.constraint(equalTo: subLabelWWDC.topAnchor, constant: -8).isActive = true
        mainLabelWWDC.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 8).isActive = true
        mainLabelWWDC.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 8).isActive = true
        
        
        mainLabelWWDC.fadeIn()
        subLabelWWDC.fadeIn()
        planetViewSharing.fadeIn()
        
        UIView.animate(withDuration: 1, animations: {
            self.effectView.effect = UIBlurEffect(style: .dark)
        }) { (_) in
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(IntroViewController.btnForMenu3OnReturn))
            self.view.addGestureRecognizer(tapGesture)
        }
        
    }
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func speak(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
    }
    
    func btnForMenu3OnReturn() {
        view.gestureRecognizers?.removeAll()
        mainLabelWWDC.fadeOut()
        subLabelWWDC.fadeOut()
        planetViewSharing.fadeOut()
        
        UIView.animate(withDuration: 1, animations: {
            self.effectView.effect = nil
            
        }) { (_) in
            self.effectView.removeFromSuperview()
            self.planetViewSharing.removeFromSuperview()
            self.subLabelWWDC.removeFromSuperview()
            self.mainLabelWWDC.removeFromSuperview()
        }
    }
    
    let imgMeShirtOff: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "me.jpg")
        return imageView
    }()
    
    let imgSharing: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let image = UIImage(named: "me_smiling.jpg")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    // WORK:
    func showMenu() {
        self.speak(text: "Wow! What a great rocket landing there. Spectacular should I say. Feel free to check out anything you want! I have a big water bottle here for you. Once again, keep it cool and stay hydrated! Take it easy!")
        let tap = UITapGestureRecognizer(target: self, action: #selector(IntroViewController.btnForMenuTapped(_:)))
        btnForMenu.addGestureRecognizer(tap)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(IntroViewController.btnForMenu2Tapped(_:)))
        btnForMenu2.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(IntroViewController.btnForMenu3Tapped(_:)))
        btnForMenu3.addGestureRecognizer(tap3)
        
//        view.addSubview(welcomeLabel)
        stackView.addArrangedSubview(btnForMenu)
        stackView.addArrangedSubview(btnForMenu2)
        stackView.addArrangedSubview(btnForMenu3)
        view.addSubview(stackView)

        view.addSubview(imgSharing)
        imgSharing.frame
        imgSharing.topAnchor.constraint(equalTo: margins.topAnchor, constant: 32).isActive = true
        imgSharing.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        imgSharing.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imgSharing.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imgSharing.layer.cornerRadius = 75
        imgSharing.layer.borderWidth = 0.2
        imgSharing.layer.borderColor = UIColor.lightGray.cgColor
        
        
        stackView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        stackView.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true

        stackView.heightAnchor.constraint(equalToConstant: CGFloat(stackView.subviews.count * 110)).isActive = true
        
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        UIView.animate(withDuration: 2, animations: {
            self.imgSharing.alpha = 1
            self.stackView.alpha = 1
        }) { (_) in
            
        }
    }
    
    func tap() {
        btnForMenu.center.y -= 20
    }
    
    func repeatIntro() {
        UIView.animate(withDuration: 1, animations: { 
            self.view.backgroundColor = .white
            
        }) { (_) in
            self.setupViews()
        }
    }
    
    var buffDude: BuffDude = {
        let buff = BuffDude()
        buff.translatesAutoresizingMaskIntoConstraints = false
        buff.backgroundColor = .clear
        buff.alpha = 0
        return buff
    }()
    
    var yellowStar: YellowStar = {
        let star = YellowStar()
        star.translatesAutoresizingMaskIntoConstraints = false
        star.backgroundColor = .clear
        star.alpha = 0
        return star
    }()
    
    let mainLabelTraining: UILabel = {
        let label = UILabel()
        let text = "GYM IS ZEN"
        label.minimumScaleFactor = 0.5
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subLabelTraining: UILabel = {
        let label = UILabel()
        let text = "Train my body. Train my mind"
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let mainLabelSharing: UILabel = {
        let label = UILabel()
        let text = "@jayvenn"
        label.minimumScaleFactor = 0.5
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subLabelSharing: UILabel = {
        let label = UILabel()
        let text = "I publish weekly iOS articles on Medium."
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    let mainLabelWWDC: UILabel = {
        let label = UILabel()
        let text = "PASSION SHARING"
        label.minimumScaleFactor = 0.5
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48)
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subLabelWWDC: UILabel = {
        let label = UILabel()
        let text = "I would like to talk with passionate developers, engage in great conversations with Apple experts, try out new technologies, attend awesome events, and share the best memories with everyone at WWDC17!"
        label.numberOfLines = 5
        label.text = text
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    var planetViewSharing: PlanetView = {
        var planet = PlanetView()
        planet.translatesAutoresizingMaskIntoConstraints = false
        planet.backgroundColor = .clear
        planet.alpha = 0
        return planet
    }()
}

public class BuffDude: UIView {
    
    private var _rotation: CGFloat = 1.0
    
    public var rotation: CGFloat {
        set (newAlpha) {
            _rotation = newAlpha
            setNeedsDisplay()
        } get {
            return _rotation
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        IntroStyleKit.drawBuffDude(frame: bounds, resizing: .stretch, leftArmRotation: rotation, rightArmRotation: rotation * -1)
    }
}

public class YellowStar: UIView {
    
    private var _rotation: CGFloat = 1.0
    
    public var rotation: CGFloat {
        set (newAlpha) {
            _rotation = newAlpha
            setNeedsDisplay()
        } get {
            return _rotation
        }
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        IntroStyleKit.drawStarYellow(frame: bounds, resizing: .stretch, starRotation: rotation)
    }
}



let introVC = IntroViewController()

PlaygroundPage.current.liveView = introVC
let player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "part1", withExtension: "m4a")!)
player.volume = 3
player.prepareToPlay()
player.play()
