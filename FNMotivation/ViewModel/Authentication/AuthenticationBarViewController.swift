//
//  AuthenticationBarViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class AuthenticationBarViewController: ButtonBarPagerTabStripViewController {
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        guard let loginViewController = storyboard?.instantiateViewController(withIdentifier: "loginViewController") as? LoginViewController else { return []}
        loginViewController.delegate = self
        
        guard let registrationViewController = storyboard?.instantiateViewController(withIdentifier: "registrationViewController") as? RegisterViewController else { return [] }
        registrationViewController.delegate = self
        return [loginViewController, registrationViewController]
    }
    
    override func viewDidLoad() {
        self.settings.style.selectedBarHeight = 4
        self.settings.style.buttonBarBackgroundColor = UIColor(named: "OffWhite")!
        self.settings.style.buttonBarItemBackgroundColor = UIColor(named: "OffWhite")!
        
        self.settings.style.selectedBarBackgroundColor = UIColor(named: "DarkBlue")!
        self.settings.style.buttonBarItemFont = UIFont(name: "Futura", size: 13.0)!
        
        self.settings.style.buttonBarItemTitleColor = UIColor(named: "DarkGray")!
        containerView.isScrollEnabled = false
        
        super.viewDidLoad()
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(named: "MediumGray")
            newCell?.label.textColor = UIColor(named: "DarkBlue")
        }
        buttonBarView.layer.shadowColor = UIColor.black.cgColor
        buttonBarView.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        buttonBarView.layer.shadowOpacity = 0.2
        buttonBarView.layer.shadowRadius = 6
        buttonBarView.layer.masksToBounds =  false
    }
}

extension AuthenticationBarViewController: LoginViewDelegate {
    func loginSuccessful(token: String) {
        if let authenticationViewController = self.parent as? AuthenticationViewController {
            authenticationViewController.dismiss(animated: true, completion: nil)
        }
        print("Bar: \(token)")
    }
}
extension AuthenticationBarViewController: SignupViewDelegate {
    func signupSuccessful() {
        if let authenticationViewController = self.parent as? AuthenticationViewController {
            authenticationViewController.dismiss(animated: true, completion: nil)
        }
    }
}
