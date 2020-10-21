//
//  AccountDataObject.swift
//  FNMotivation
//
//  Created by Michael Amiro on 25/09/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation
import Alamofire

class AccountDataObject {
    func fetchProfileData(completion: @escaping (Bool, UserProfileData?)->()){
        guard let url = URL(string: NetworkingValues.apiUrl + "/users/profile/27") else { return }
        let urlRequest = URLRequest(url: url)
        
        AF.request(urlRequest).validate().responseDecodable(of: ProfileResponse.self) { (response) in
            guard let profileResponse = response.value else {
                return
            }
            let profileData = profileResponse.data
            completion(true, profileData)
        }
    }
}
