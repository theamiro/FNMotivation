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
    
    func currentSessionIsActive()->Bool{
        return defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String != nil ? true : false
    }
    
    func storeUserNames(withData userdata: UserProfileData){
        defaultsHolder.set(userdata.fullname, forKey: DefaultValues.fullname)
    }
    
    func performUserAuthentication(userEmail: String, password: String, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "email": userEmail,
            "password": password
        ]
        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/auth/login"), networkCallType: .post, requestBody: parameters) { (state, message, dataObject) in
            if state {
                if let response = dataObject as? [String: Any] {
                    let message = response["msg"] as? String
                    guard let token = response["token"] as? String else {
                        completion(false, message!)
                        return
                }
                    AuthenticationManager.shared.createUserSession(withNewToken: token)
                    completion(true, "Welcome. You can now post and comment on FNMotivation!")
                }
            } else {
                AlertsController().generateAlert(withError: message)
                completion(state, message)
            }
        }
    }
    
    func performUserRegistration(username: String, firstName: String, lastName: String, userEmail: String, password: String, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "username": username,
            "firstname": firstName,
            "lastname": lastName,
            "email": userEmail,
            "password": password
        ]
        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/auth/register"), networkCallType: .post, requestBody: parameters) { (state, message, dataObject) in
            if state {
                guard let response = dataObject as? [String:Any],
                    let token = response["token"] as? String else {
                        completion(false, ErrorMessage.parseError)
                        return
                }
                AuthenticationManager().createUserSession(withNewToken: token)
                completion(true, "Congratulations! You are now able to take full advantage of FNMotivation®.")
            } else {
                //                AlertsController().generateAlert(withError: message)
                print(message)
                completion(state, message)
            }
        }
    }
//    func logoutUser(completion: @escaping (Bool, String)->()){
    func logoutUser(completion: @escaping (String)->()){
        self.removeUserSession()
        completion("Logout Successful")
//        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/user/logout"), networkCallType: .post, headerEnabled: true) { (state, message, dataObject) in
//            if state {
//                guard let response = dataObject as? [String:Any], let userMessage = response["message"] as? String else {
//                    completion(false, ErrorMessage.parseError)
//                    return
//                }
                self.removeUserSession()
//                completion(true, userMessage)
//            } else {
//                AlertsController().generateAlert(withError: message)
//                completion(state, message)
//            }
//        }
    }
    
    private func removeUserSession(){
        if defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.tokenKey)
        }
        if defaultsHolder.value(forKey: DefaultValues.fullname) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.fullname)
        }
    }
}
