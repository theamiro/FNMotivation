//
//  ProfileViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class AccountViewController: FNViewController {
    
    let authNotificationName = Notification.Name(DefaultValues.authNotificationKey)
    let logoutNotificationName = Notification.Name(DefaultValues.logoutNotificationKey)
    let signUpNotificationName = Notification.Name(DefaultValues.signUpNotificationKey)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        handleAuthenticatedState()
        createObservers()
    }
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.handleAuth(notification:)), name: authNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.handleAuth(notification:)), name: logoutNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AccountViewController.handleAuth(notification:)), name: signUpNotificationName, object: nil)
    }
    
    @objc
    func handleAuth(notification: NSNotification) {
        handleAuthenticatedState()
    }
    
    func handleAuthenticatedState() {
        if AuthenticationManager().currentSessionIsActive() {
            fullNameLabel.text = defaultsHolder.value(forKey: DefaultValues.fullname) as? String
            profileImage.image = UIImage(named: "avatar")
            followersLabel.text = "0"
            followingLabel.text = "0"
        } else {
            fullNameLabel.text = "Sign in or Create an Account"
            profileImage.image = #imageLiteral(resourceName: "avatar")
            followersLabel.text = "-"
            followingLabel.text = "-"
        }
    }
}
