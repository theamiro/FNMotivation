//
//  Networking.swift
//  FNMotivation
//
//  Created by Michael Amiro on 09/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum NetworkCallType {
    case get
    case post
    case put
    case delete
}

class NetworkingService {
    
    private init() {}
    static let shared = NetworkingService()
    
    func makeCall(fromUrl url: String, networkCallType: NetworkCallType, requestBody: [String: Any] = [:], headerEnabled: Bool = false, completion: @escaping (Bool, String, Any?)->()) {
        
        guard let validUrl = URL(string: url) else {
            print("NETWORK ERROR: Invalid url")
            completion(false, "NETWORK ERROR: Invalid url", nil)
            return
        }
        var requestControl = URLRequest(url: validUrl)
        
        switch networkCallType {
            case .get:
                requestControl.httpMethod = HTTPMethod.get.rawValue
            case .post:
                requestControl.httpMethod = HTTPMethod.post.rawValue
                requestControl.setValue("application/json", forHTTPHeaderField: "Content-Type")
                do {
                    requestControl.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
                } catch {
                    print("error is:\n", error.localizedDescription)
                    completion(false, "NETWORK ERROR: could not attach header", nil)
            }
            case .put:
                requestControl.httpMethod = HTTPMethod.put.rawValue
                requestControl.setValue("application/json", forHTTPHeaderField: "Content-Type")
                do {
                    requestControl.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
                } catch {
                    print("error is:\n", error.localizedDescription)
                    completion(false, "NETWORK ERROR: could not attach header", nil)
            }
            case .delete:
                requestControl.httpMethod = HTTPMethod.delete.rawValue
        }
        
        if headerEnabled, let userToken = defaultsHolder.value(forKey: DefaultValues.tokenKey) as? String {
            requestControl.setValue(("Bearer " + userToken), forHTTPHeaderField: "Authorization")
        }
        
        AF.request(requestControl).validate().responseJSON { response in
            switch response.result {
                case .success:
                    if let jsonOutput = response.value {
                        completion(true, "success", jsonOutput)
                    } else {
                        completion(true, "success with no JSON output.", nil)
                }
                case .failure(let error):
                    if let jsonOutput = response.value {
                        completion(false, error.localizedDescription, jsonOutput)
                    } else {
                        completion(false, error.localizedDescription, nil)
                }
            }
        }
    }
}
