//
//  AboutViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 24/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTextView.textContainerInset = UIEdgeInsets(top: 0, left: 15.0, bottom: 0, right: 15.0)
    }
}
