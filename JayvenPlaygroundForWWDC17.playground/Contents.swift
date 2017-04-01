//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

public let coolBlue = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.00)


public class AboutMeViewController: UIViewController {
    
    var margins = UILayoutGuide()
    
    //Come up with own music
    //Use sound
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to my playground!"
        return label
    }()

    override public func loadView() {
        view = UIView()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = coolBlue
        margins = view.layoutMarginsGuide
    }
    
    func setupView() {
        
    }

    public override func viewDidLoad() {
        funBox()
    }
    
    func funBox() {
        var containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = view.frame.width
        let height = view.frame.height
        let length: CGFloat = width/4

        containerView.backgroundColor = .white
        containerView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        
        containerView.heightAnchor.constraint(equalToConstant: length).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: length).isActive = true
    }
    
    func pan(_ sender: AnyObject) {
        
        
    }

}

let introVC = IntroViewController()
let aboutMeVC = AboutMeViewController()
introVC.aboutMeVC = aboutMeVC

PlaygroundPage.current.liveView = introVC

