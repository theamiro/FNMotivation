//
//  DefaultValues.swift
//  FNMotivation
//
//  Created by Michael Amiro on 09/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

public let defaultsHolder = UserDefaults.standard

class DefaultValues {
    static let fullname = "USER_FULLNAME"
    static let tokenKey = "USER_TOKEN"
    static let authNotificationKey = "authNotificationKey"
    static let logoutNotificationKey = "logoutNotificationKey"
    static let signUpNotificationKey = "signUpNotificationKey"
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
