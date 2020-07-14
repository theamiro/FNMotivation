//
//  AuthenticationManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 12/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

class AuthenticationManager {
    func createUserSession(withNewToken newToken: String){
        if defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.tokenKey)
        }
        defaultsHolder.set(newToken, forKey: DefaultValues.tokenKey)
    }
}
