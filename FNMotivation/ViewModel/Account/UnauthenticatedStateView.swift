//
//  UnauthenticatedStateView.swift
//  FNMotivation
//
//  Created by Michael Amiro on 08/10/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class UnauthenticatedStateView: UIViewController {

    @IBOutlet weak var authenticationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func authenticationButtonTapped() {
        let authenticationViewController = UIStoryboard(name: "Main", bundle:
            Bundle.main).instantiateViewController(withIdentifier:
                "authenticationViewController") as! AuthenticationViewController
        authenticationViewController.modalPresentationStyle = .formSheet
        self.present(authenticationViewController, animated: true, completion: nil)
    }
}
