//
//  BaseViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

protocol BaseViewDelegate: class {
    
}

class BaseViewController: UIViewController {
    
    @IBOutlet var recognizer: UIPanGestureRecognizer!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var contentContainer: UIView!
    
    @IBOutlet weak var menuContainerLeading: NSLayoutConstraint!
    @IBOutlet weak var contentContainerLeading: NSLayoutConstraint!
    
    var menuVisible: Bool = false
    
    private let overlay = UIView()
    private let tapRecognizer = UITapGestureRecognizer()
    
    var menuViewController: MenuViewController?
    weak var delegate: BaseViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuContainerLeading.constant = 0 - menuContainer.frame.size.width
        overlay.frame = CGRect(x: 0, y: 0, width: contentContainer.frame.width, height: contentContainer.frame.height)
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.addTarget(self, action: #selector(hideSideMenu))
        overlay.addGestureRecognizer(tapRecognizer)
        addOverlay()
        
        
        for childViewController in self.children {
            if let sideMenu = childViewController as? MenuViewController {
                menuViewController = sideMenu
                break
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
//    @IBAction func swipeForMenu(_ sender: Any) {
//        let translation = recognizer.translation(in: self.view)
//        if(recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled){
//            if(menuVisible){
//                if(translation.x < 0){
//                    toggleSideMenu(fromViewController: self)
//                }
//            } else {
//                if(translation.x > 100.0){
//                    toggleSideMenu(fromViewController: self)
//                } else {
//                    view.layoutIfNeeded()
//                    UIView.animate(withDuration: 0.3, animations: {
//                        self.menuContainerLeading.constant = 0 - self.menuContainer.frame.size.width
//                        self.contentContainerLeading.constant = 0
//                        self.overlay.alpha = 0
//                        self.view.layoutIfNeeded()
//                    })
//                }
//            }
//            return
//        }
//
//        // if side menu is not visisble
//        // and user finger move to right
//        // and the distance moved is smaller than the side menu's width
//        if(!menuVisible && translation.x > 0.0 && translation.x <= menuContainer.frame.size.width) {
//            menuContainerLeading.constant = 0 - menuContainer.frame.size.width + translation.x
//            overlay.alpha = translation.x / 500
//            contentContainerLeading.constant = 0 + translation.x
//        }
//        // if the side menu is visible
//        // and user finger move to left
//        // and the distance moved is smaller than the side menu's width
//        if(menuVisible && translation.x >= 0 - menuContainer.frame.size.width && translation.x < 0.0) {
//            menuContainerLeading.constant = 0 + translation.x
//            overlay.alpha = 0.5 + translation.x / 500
//            contentContainerLeading.constant = menuContainer.frame.size.width + translation.x
//        }
//    }
    
    @objc func hideSideMenu(){
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            self.menuContainerLeading.constant = 0 - self.menuContainer.frame.size.width
            self.contentContainerLeading.constant = 0
            self.overlay.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: {(_ ) in
            self.menuVisible = false
        })
    }
    
    func toggleSideMenu(fromViewController: UIViewController) {
        if menuVisible {
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
                self.menuContainerLeading.constant = 0 - self.menuContainer.frame.size.width // hide the side menu to the left
                self.contentContainerLeading.constant = 0 // move the content view to original position
                self.contentContainer.alpha = 1
                self.overlay.alpha = 0
                self.view.layoutIfNeeded()
            })
        } else {
            self.menuViewController?.currentNavigationController = fromViewController.navigationController
            self.view.layoutIfNeeded()
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
                self.menuContainerLeading.constant = 0 // move the side menu to the right to show it
                self.contentContainerLeading.constant = self.menuContainer.frame.size.width // move the content view to the right
                self.contentContainer.alpha = 1
                self.overlay.alpha = 0.5
                self.view.layoutIfNeeded()
            })
        }
        menuVisible = !menuVisible
    }
    
    func addOverlay() {
        self.contentContainer.addSubview(self.overlay)
        self.overlay.heightAnchor.constraint(equalTo: self.contentContainer.heightAnchor, multiplier: 1).isActive = true
        self.overlay.widthAnchor.constraint(equalToConstant: self.view.frame.width - self.menuContainer.frame.width).isActive = true
        self.overlay.leadingAnchor.constraint(equalTo: self.contentContainer.leadingAnchor).isActive = true
        self.overlay.centerYAnchor.constraint(equalTo: self.contentContainer.centerYAnchor).isActive = true
    }
}
