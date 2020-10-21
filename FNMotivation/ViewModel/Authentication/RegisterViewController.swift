//
//  RegisterViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SafariServices

protocol SignupViewDelegate: class{
    func signupSuccessful()
}

class RegisterViewController: UIViewController, IndicatorInfoProvider, SFSafariViewControllerDelegate {
    
    weak var delegate: SignupViewDelegate!
    
    @IBOutlet weak var usernameTextField: FNTextField!
    @IBOutlet weak var firstNameTextField: FNTextField!
    @IBOutlet weak var emailAddressTextField: FNTextField!
    @IBOutlet weak var passwordTextField: FNTextField!
    @IBOutlet weak var termsTextView: UITextView!
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "SIGNUP")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTermsOfUse()
        
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        if let username = usernameTextField.text,
            let firstName = firstNameTextField.text,
            let emailAddress = emailAddressTextField.text,
            let password = passwordTextField.text {
            AuthenticationManager().performUserRegistration(username: username, firstName: firstName, lastName: firstName, userEmail: emailAddress, password: password) { (state, message) in
                if state {
                    self.delegate.signupSuccessful()
                    AlertsController().generateAlert(withSuccess: message, andTitle: "Welcome")
                } else {
//                    resetForm()
                    AlertsController().generateAlert(withError: "Missing Fields!")
                }
            }
        } else {
            AlertsController().generateAlert(withError: "Missing Fields!")
        }
    }
    
    func setTermsOfUse() {
        let url = NetworkingValues.termsOfUse
        let attributedString = NSMutableAttributedString(string: "By signing up, you accept the terms of use.")
        attributedString.setAttributes([.link: url], range: NSMakeRange(30, 12))
        self.termsTextView.attributedText = attributedString
        self.termsTextView.font = UIFont(name: "Futura-Medium", size: 13.0)
        self.termsTextView.textAlignment = .center
        self.termsTextView.textColor = .lightGray
        self.termsTextView.linkTextAttributes = [
            .foregroundColor: UIColor(named: "Orange")!,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        self.termsTextView.delegate = self
    }
    
}

extension RegisterViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let termsOfUseView = SFSafariViewController(url: NSURL(string: NetworkingValues.termsOfUse)! as URL)
        termsOfUseView.preferredBarTintColor = .white
        termsOfUseView.preferredControlTintColor = UIColor(named: "DarkBlue")
        termsOfUseView.dismissButtonStyle = .close
        termsOfUseView.title = "Terms of Use"
        self.present(termsOfUseView, animated: true, completion: nil)
        termsOfUseView.delegate = self
        
        return false
    }
}
