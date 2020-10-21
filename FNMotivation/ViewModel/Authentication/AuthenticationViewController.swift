//
//  AuthenticationViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import AuthenticationServices
import Firebase
import GoogleSignIn

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageSubtitleLabel: UILabel!
    @IBOutlet weak var authenticationServicesButton: UIButton!
    @IBOutlet weak var GIDSignInButton: UIButton!
    @IBOutlet weak var parentView: FNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        initializeSignInOptions()
    }
    func initializeView() {
        parentView.layer.cornerRadius = 20
        parentView.layer.shadowColor = UIColor.black.cgColor
        parentView.layer.shadowOffset = CGSize.zero
        parentView.layer.shadowOpacity = 0.1
        parentView.layer.shadowRadius = 6
        parentView.layer.masksToBounds = false
        parentView.layer.borderWidth = 2.0
        parentView.layer.borderColor = UIColor(named: "BrilliantWhite")?.cgColor
    }
    
    fileprivate func initializeSignInOptions() {
        authenticationServicesButton.addTarget(self, action: #selector(handleAppleAuthenticationService), for: .touchUpInside)
        GIDSignInButton.addTarget(self, action: #selector(handleSecondaryAuthentication), for: .touchUpInside)
    }
    
    @objc
    func handleAppleAuthenticationService() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    @objc
    func handleSecondaryAuthentication() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}
extension AuthenticationViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                // Create an account in your system.
                let userIdentifier = appleIDCredential.user
                let firstName = appleIDCredential.fullName?.givenName
                let lastName = appleIDCredential.fullName?.familyName
                let emailAddress = appleIDCredential.email
            
            case let passwordCredential as ASPasswordCredential:
                // Sign in using an existing iCloud Keychain credential.
                let username = passwordCredential.user
                let password = passwordCredential.password
            
            default:
                break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let alert = UIAlertController(title: "Authorization Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension AuthenticationViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

extension AuthenticationViewController: LoginViewDelegate {
    func loginSuccessful(token: String) {
        print("Auth: \(token)" )
    }
}
