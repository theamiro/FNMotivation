//
//  ProfileViewController.swift
//  FNMotivation
//
//  Created by Michael Amiro on 21/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import XLPagerTabStrip

// MARK: - Welcome
struct ProfileResponse: Decodable {
    let success: Bool
    let data: UserProfileData
}

struct UserProfileData: Decodable {
    let id: String
    let username: String
    let email: String
    let avatar: String
}

class ProfileViewController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(stringLiteral: "PROFILE")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
