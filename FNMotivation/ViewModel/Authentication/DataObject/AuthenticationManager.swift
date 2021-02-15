//
//  AuthenticationManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 12/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation
import JWTDecode
import SwiftyJSON
import FirebaseMessaging

enum AuthProvider {
    case google
    case apple
}

class AuthenticationManager {
    static let shared = AuthenticationManager.init()
    
    let deviceID = AppDelegate().deviceTokenString
    let fcmToken = Messaging.messaging().fcmToken
    
//    MARK: - Session
    func createUserSession(withNewToken newToken: String){
        if defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.tokenKey)
        }
        defaultsHolder.set(newToken, forKey: DefaultValues.tokenKey)
    }
    
    func currentSessionIsActive()->Bool{
        return defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String != nil ? true : false
    }
    
    func storeUserNames(withData fullName: String){
        defaultsHolder.set(fullName, forKey: DefaultValues.fullname)
    }
    
    func logoutUser(completion: @escaping (String)->()){
        self.removeUserSession()
        completion("Logout Successful")
    }
    
    private func removeUserSession(){
        if defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.tokenKey)
        }
        if defaultsHolder.value(forKey: DefaultValues.fullname) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.fullname)
        }
        if defaultsHolder.value(forKey: DefaultValues.avatar) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.avatar)
        }
        if defaultsHolder.value(forKey: DefaultValues.email) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.email)
        }
        if defaultsHolder.value(forKey: DefaultValues.username) as? String != nil {
            defaultsHolder.removeObject(forKey: DefaultValues.username)
        }
    }
    
//    MARK: - Basic Auth
    func performUserAuthentication(userEmail: String, password: String, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "email": userEmail,
            "password": password,
            "device_id": deviceID,
            "device_token": deviceID,
            "fcmToken": fcmToken!,
            "os_version": "iOS"
        ]
        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/auth/login"), networkCallType: .post, requestBody: parameters) { (state, message, dataObject) in
            if state {
                if let response = dataObject as? [String: Any] {
                    let message = response["msg"] as? String
                    guard let token = response["token"] as? String else {
                        completion(false, message!)
                        return
                    }
                    do {
                        let jwt = try decode(jwt: token)
                        let jwtBody = jwt.body
                        guard let user = jwtBody["user"] as? [String: Any] else {
                            return
                        }
                        guard let username = user["username"] as? String,
//                              let userID = user["userid"] as? String,
                              let email = user["email"] as? String,
                              let avatar = user["avatar"] as? String else {
                            completion(false, "Failed to decode JWT")
                            return
                        }
//                        defaultsHolder.set(fullName, forKey: DefaultValues.fullname)
                        defaultsHolder.set(username, forKey: DefaultValues.username)
                        defaultsHolder.set(email, forKey: DefaultValues.email)
                        defaultsHolder.set(avatar, forKey: DefaultValues.avatar)
                        
                        completion(true, "Welcome back!")
                        AuthenticationManager.shared.storeUserNames(withData: username)
                    } catch {
                        print(error)
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
    
//    MARK: - Registration
    func performUserRegistration(username: String, firstName: String, lastName: String, userEmail: String, password: String, completion: @escaping (Bool, String)->()) {
        
        let parameters: [String: Any] = [
            "username": username,
            "firstname": firstName,
            "lastname": lastName,
            "email": userEmail,
            "password": password,
            "device_id": deviceID,
            "device_token": deviceID,
            "fcmToken": fcmToken!,
            "os_version": "iOS"
        ]
        
        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/auth/register"), networkCallType: .post, requestBody: parameters) { (state, message, dataObject) in
            if state {
                guard let response = dataObject as? [String:Any] else {
                    completion(false, ErrorMessage.parseError)
                    return
                }
                let message = response["msg"] as? String
                
                guard let token = response["token"] as? String else {
                    completion(false, message!)
                    return
                }
                do {
                    let jwt = try decode(jwt: token)
                    let jwtBody = jwt.body
                    guard let user = jwtBody["user"] as? [String: Any] else {
                        return
                    }
                    guard let username = user["username"] as? String,
//                              let userID = user["userid"] as? String,
                          let email = user["email"] as? String,
                          let avatar = user["avatar"] as? String else {
                        completion(false, "Failed to decode JWT")
                        return
                    }
//                        defaultsHolder.set(fullName, forKey: DefaultValues.fullname)
                    defaultsHolder.set(username, forKey: DefaultValues.username)
                    defaultsHolder.set(email, forKey: DefaultValues.email)
                    defaultsHolder.set(avatar, forKey: DefaultValues.avatar)
                    
                    completion(true, message!)
                } catch {
                    print(error)
                }
                self.createUserSession(withNewToken: token)
                self.storeUserNames(withData: "\(firstName) \(lastName)")
                
                completion(true, "Congratulations! You are now able to take full advantage of FNMotivation®.")
            } else {
                AlertsController().generateAlert(withError: message)
                completion(state, message)
            }
        }
    }
    
//    MARK: - Third-party Auth
    func performThirdPartyRegistration(provider: AuthProvider, email: String, userID: String, fullName: String, token: String, avatar: String, deviceID: String, deviceToken: String, fcmToken: String, completion: @escaping (Bool, String)->()) {
        switch provider {
            case .google:
                let parameters: [String: Any] = [
                    "email": email,
                    "fullname": fullName,
                    "google_id": userID,
                    "googleToken": token,
                    "avatar": avatar,
                    "device_id": deviceID,
                    "device_token": deviceToken,
                    "fcm_token": fcmToken,
                    "os_version": "iOS"
                ]
                NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/auth/googleLogin", networkCallType: .post, requestBody: parameters) { [weak self] (state, message, dataObject)  in
                    if state {
                        guard let response = dataObject as? [String:Any] else {
                            completion(false, ErrorMessage.parseError)
                            return
                        }
                        if response["success"] as? Bool == true {
                            guard let token = response["token"] as? String else {
                                completion(false, ErrorMessage.missingData)
                                return
                            }
                            AuthenticationManager().createUserSession(withNewToken: token)
                            self!.storeUserNames(withData: fullName)
                            completion(true, "Congratulations! You are now able to take full advantage of FNMotivation®.")
                        } else {
                            completion(false, ErrorMessage.noData)
                        }
                    } else {
                        AlertsController().generateAlert(withError: message)
                        completion(state, message)
                    }
                }
            break
            case .apple:
                let parameters: [String: Any] = [
                    "email": email,
                    "fullname": fullName,
                    "apple_id": userID,
                    "appleToken": token,
                    "avatar": avatar,
                    "device_id": deviceID,
                    "device_token": deviceToken,
                    "fcm_token": fcmToken,
                    "os_version": "iOS"
                ]
                NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/auth/appleLogin", networkCallType: .post, requestBody: parameters) { [weak self] (state, message, dataObject)  in
                    if state {
                        guard let response = dataObject as? [String:Any], let token = response["token"] as? String else {
                            completion(false, ErrorMessage.parseError)
                            return
                        }
                        AuthenticationManager().createUserSession(withNewToken: token)
//                        Fix the name issue Unexpectedly found nil while unwrapping an Optional value
                        self!.storeUserNames(withData: fullName)
                        completion(true, "Congratulations! You are now able to take full advantage of FNMotivation®.")
                    } else {
                        AlertsController().generateAlert(withError: message)
                        completion(state, message)
                    }
                }
            break
        }

    }
}
