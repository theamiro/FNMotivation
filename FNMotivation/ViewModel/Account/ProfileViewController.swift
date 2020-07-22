//
//  ProfileViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 21/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension ProfileViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(stringLiteral: "Profile")
    }
}
