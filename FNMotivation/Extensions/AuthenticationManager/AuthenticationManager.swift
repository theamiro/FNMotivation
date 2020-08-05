//
//  AuthenticationManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 12/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

class AuthenticationManager {
    static let shared = AuthenticationManager.init()
    
    func createUserSession(withNewToken newToken: String){
        if defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.tokenKey)
        }
        defaultsHolder.set(newToken, forKey: DefaultValues.tokenKey)
    }
    
    func performUserAuthentication(userEmail: String, password: String, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "email": userEmail,
            "password": password
        ]
        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/users/login"), networkCallType: .post, requestBody: parameters) { (state, message, dataObject) in
            if state {
                guard let response = dataObject as? [String: Any],
                    let token = response["token"] as? String else {
                    completion(false, ErrorMessage.parseError)
                    return
                }
                AuthenticationManager.shared.createUserSession(withNewToken: token)
                completion(true, "Welcome. You can now post and comment on FNMotivation!")
            } else {
                AlertsController().generateAlert(withError: message)
                completion(state, message)
            }
        }
    }
    
    func performUserRegistration(username: String, userEmail: String, password: String, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "username": username,
            "email": userEmail,
            "password": password
        ]
        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/users/register"), networkCallType: .post, requestBody: parameters) { (state, message, dataObject) in
            if state {
                guard let response = dataObject as? [String: Any],
                    let token = response["token"] as? String else {
                        completion(false, ErrorMessage.parseError)
                        return
                }
                AuthenticationManager.shared.createUserSession(withNewToken: token)
                completion(true, "Welcome. You can now post and comment on FNMotivation!")
            } else {
                AlertsController().generateAlert(withError: message)
                completion(state, message)
            }
        }
    }
}
