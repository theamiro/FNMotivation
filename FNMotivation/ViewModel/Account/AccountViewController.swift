//
//  ProfileViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 20/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class AccountViewController: FNViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func handleAuthenticatedState() {
        if AuthenticationManager().currentSessionIsActive() {
            fullNameLabel.text = "Your Name Here"
            
        } else {
            fullNameLabel.text = "Sign in or Create an Account"
            profileImage.image = UIImage(named: "avatar")
            followersLabel.text = "-"
            followingLabel.text = "-"
        }
    }
}
