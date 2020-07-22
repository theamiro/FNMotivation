//
//  AuthenticationViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 14/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var pageSubtitleLabel: UILabel!
    @IBOutlet weak var authenticationServicesButton: UIButton!
    @IBOutlet weak var GIDSignInButton: UIButton!
    @IBOutlet weak var parentView: FNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parentView.layer.cornerRadius = 20
        parentView.layer.shadowColor = UIColor.black.cgColor
        parentView.layer.shadowOffset = CGSize.zero
        parentView.layer.shadowOpacity = 0.1
        parentView.layer.shadowRadius = 6
        parentView.layer.masksToBounds = false
        parentView.layer.borderWidth = 2.0
        parentView.layer.borderColor = UIColor(named: "BrilliantWhite")?.cgColor
    }
}
