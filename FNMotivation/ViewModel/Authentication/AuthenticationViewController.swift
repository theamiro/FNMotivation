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
    
    let authNotificationName = Notification.Name(DefaultValues.authNotificationKey)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageSubtitleLabel: UILabel!
    @IBOutlet weak var authenticationServicesButton: UIButton!
    @IBOutlet weak var GIDSignInButton: UIButton!
    @IBOutlet weak var parentView: FNView!
    
    weak var loginDelegate: LoginViewDelegate?
    weak var signupDelegate: SignupViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        initializeSignInOptions()
        createObservers()
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(AuthenticationViewController.dismiss(animated:completion:)), name: authNotificationName, object: nil)
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
                guard let givenName = appleIDCredential.fullName?.givenName else { return }
                guard let familyName = appleIDCredential.fullName?.familyName else { return }
                
                var fullName: String {
                    return givenName + " " + familyName
                }
                guard let email = appleIDCredential.email,
                    let token = appleIDCredential.identityToken?.base64EncodedString() else {
                            AlertsController().generateAlert(withError: "Error getting Apple Sign in Credentials")
                            return
                }
                
                AuthenticationManager().performThirdPartyRegistration(provider: .apple, email: email, userID: userIdentifier, fullName: fullName, token: token, avatar: "") { (state, message) in
                    if state {
                        AlertsController().generateAlert(withSuccess: message, andTitle: "Welcome back!")
                        guard let token = defaultsHolder.string(forKey: DefaultValues.tokenKey) else { return }
                        
                        let authNotification = Notification.Name(DefaultValues.authNotificationKey)
                        NotificationCenter.default.post(name: authNotification, object: nil, userInfo: ["token": token])
                        self.loginDelegate?.loginSuccessful()
                    } else {
                        AlertsController().generateAlert(withError: message)
                    }
            }
            
            case let passwordCredential as ASPasswordCredential:
                // Sign in using an existing iCloud Keychain credential.
                let username = passwordCredential.user
                let password = passwordCredential.password
            
                AuthenticationManager().performUserAuthentication(userEmail: username, password: password) { (state, message) in
                    if state {
                        AlertsController().generateAlert(withSuccess: message, andTitle: "Welcome back!")
                        guard let token = defaultsHolder.string(forKey: DefaultValues.tokenKey) else { return }
                        
                        let authNotification = Notification.Name(DefaultValues.authNotificationKey)
                        NotificationCenter.default.post(name: authNotification, object: nil, userInfo: ["token": token])
                        self.loginDelegate?.loginSuccessful()
                    } else {
                        AlertsController().generateAlert(withError: message)
                    }
            }
            default:
                break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        AlertsController().generateAlert(withError: error.localizedDescription)
    }
}

extension AuthenticationViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

extension AuthenticationViewController: LoginViewDelegate {
    func loginSuccessful() {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AuthenticationViewController: SignupViewDelegate {
    func signupSuccessful() {
        self.dismiss(animated: true, completion: nil)
    }
}
