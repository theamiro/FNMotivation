//
//  LoginViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import Alamofire
import XLPagerTabStrip

class LoginViewController: UIViewController, IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "LOGIN")
    }
    
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: FNCheckBox!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10
        loginButton.layer.shadowColor = UIColor(named: "DarkBlue")?.cgColor
        loginButton.layer.shadowOffset = CGSize.zero
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.shadowRadius = 6
        loginButton.layer.masksToBounds =  false
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        loginButton.setTitle("Logging in...", for: .normal)
        AuthenticationManager.shared.performUserAuthentication(userEmail: emailAddressTextField.text!, password: passwordTextField.text!) { (state, message) in
            if state {
                print(message)
                if let authenticationViewController = self.parent?.parent as? AuthenticationViewController {
                    print("This is the correct view controller to dismiss")
                    authenticationViewController.dismiss(animated: true, completion: nil)
                }
            } else {
                print(message)
            }
        }
    }
}
