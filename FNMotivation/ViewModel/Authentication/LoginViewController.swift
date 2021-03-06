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

protocol LoginViewDelegate: class{
    func loginSuccessful()
}

class LoginViewController: UIViewController, IndicatorInfoProvider {
    
    weak var delegate: LoginViewDelegate?
    
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
        if let email = emailAddressTextField.text,
            let password = passwordTextField.text {
            AuthenticationManager().performUserAuthentication(userEmail: email, password: password) { (state, message) in
                if state {
                    AlertsController().generateAlert(withSuccess: message, andTitle: "Welcome back!")
                    guard let token = defaultsHolder.string(forKey: DefaultValues.tokenKey) else { return }
                    
                    DispatchQueue.main.async {
                        let authNotification = Notification.Name(DefaultValues.signUpNotificationKey)
                        NotificationCenter.default.post(name: authNotification, object: nil, userInfo: ["token": token])
                    }
                } else {
                    self.resetForm()
                    AlertsController().generateAlert(withError: message)
                }
            }
        } else {
            AlertsController().generateAlert(withError: "There are some missing fields!")
        }
    }
    private func resetForm() {
        loginButton.setTitle("Log in", for: .normal)
        passwordTextField.text = ""
    }
}
