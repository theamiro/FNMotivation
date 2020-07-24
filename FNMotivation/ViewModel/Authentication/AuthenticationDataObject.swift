//
//  AuthenticationManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 12/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AuthenticationDataObject {
    func performUserRegistration(username: String, firstName: String, lastName: String, userEmail: String, gender: String, birthdate: String, password: String, newsletterSubscription: Int, avatar: String, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "username": username,
            "firstname": firstName,
            "lastname": lastName,
            "email": userEmail,
            "gender": gender,
            "birthdate": birthdate,
            "password": password,
            "subscribe_newsletter": newsletterSubscription,
            "avatar": avatar
        ]
        
        NetworkingService.shared.makeCall(fromUrl: (NetworkingValues.apiUrl + "/users/register"), networkCallType: .post, requestBody: parameters) { (state, message, dataObject) in
            if state {
                guard let response = dataObject as? [String:Any],
                    let token = response["token"] as? String else {
                    completion(false, ErrorMessage.parseError)
                    return
                }
                AuthenticationManager().createUserSession(withNewToken: token)
                completion(true, "Congratulations! You are now able to take full advantage of TaxPayr®.")
            } else {
//                AlertsController().generateAlert(withError: message)
                print(message)
                completion(state, message)
            }
        }
    }
}
