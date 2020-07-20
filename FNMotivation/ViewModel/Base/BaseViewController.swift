//
//  BaseViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var menuContainerLeading: NSLayoutConstraint!
    @IBOutlet weak var contentContainerCenter: NSLayoutConstraint!
    @IBOutlet weak var overlayView: UIView!
    var menuVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuContainerLeading.constant = 0 - menuContainer.frame.size.width
    }
    
    func showSideMenu(){
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            self.menuContainerLeading.constant = 0
            self.contentContainerCenter.constant = 0 + self.menuContainer.frame.size.width
            self.view.layoutIfNeeded()
        }, completion: { (_ ) in
            self.menuVisible = true
        })
    }
    
    func hideSideMenu(){
        UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
            self.menuContainerLeading.constant = 0 - self.menuContainer.frame.size.width
            self.contentContainerCenter.constant = 0
            self.view.layoutIfNeeded()
        }, completion: {(_ ) in
            self.menuVisible = false
        })
    }
    
    func toggleSideMenu() {
        if menuVisible {
            hideSideMenu()
        } else {
            showSideMenu()
        }
    }
}
