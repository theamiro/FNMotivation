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

class RegisterViewController: UIViewController, IndicatorInfoProvider, SFSafariViewControllerDelegate {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "SIGNUP")
    }
    
   
    @IBOutlet weak var usernameTextField: FNTextField!
    @IBOutlet weak var firstNameTextField: FNTextField!
    @IBOutlet weak var emailAddressTextField: FNTextField!
    @IBOutlet weak var passwordTextField: FNTextField!
    @IBOutlet weak var termsTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setTermsOfUse()
        
    }
    
    func setTermsOfUse() {
        let url = NetworkingValues.termsOfUse
        let attributedString = NSMutableAttributedString(string: "By signing up, you accept the terms of use.")
        attributedString.setAttributes([.link: url], range: NSMakeRange(30, 12))
        self.termsTextView.attributedText = attributedString
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
        termsOfUseView.preferredControlTintColor = UIColor(named: "Accent")
        termsOfUseView.dismissButtonStyle = .done
        termsOfUseView.title = "Terms of Use"
        self.present(termsOfUseView, animated: true, completion: nil)
        termsOfUseView.delegate = self
        
        return false
    }
}
