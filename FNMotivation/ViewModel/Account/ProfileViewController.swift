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
struct ProfileResponse: Codable {
    let success: Bool
    let data: UserProfileData
}

// MARK: - DataClass
struct UserProfileData: Codable {
    let username: String
    let fullname: String?
    let gender: String?
    let dob: String?
    let role: String
    let avatar: String?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case username, fullname, gender, dob, role, avatar
        case createdAt
    }
}

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
