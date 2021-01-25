//
//  StoryManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 25/01/2021.
//  Copyright © 2021 Michael Amiro. All rights reserved.
//

import Foundation

class StoryManager {
    func publishStory(title: String, redirectLink: String, communityID: Int, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "title": title,
            "redirect_link": redirectLink,
            "community_id": communityID
        ]
        NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/stories", networkCallType: .post, requestBody: parameters, headerEnabled: true) { (state, message, dataObject) in
            if state {
                guard let jsonResponse = dataObject as? [String:Any] else {
                    AlertsController().generateAlert(withError: ErrorMessage.parseError)
                    completion(false, ErrorMessage.parseError)
                    return
                }
                completion(true, "Your article has been posted successfully.")
//                completion(true, message)
            } else {
//                AlertsController().generateAlert(withError: message)
                completion(false, message)
            }
        }
    }
}
