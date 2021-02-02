//
//  StoryManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 25/01/2021.
//  Copyright © 2021 Michael Amiro. All rights reserved.
//

import Foundation

class StoryManager {
    func fetchStories(completion: @escaping (Bool, String, [Story]?)->()) {
        NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/stories?from=0&to=100", networkCallType: .get) { (state, message, dataObject) in
            if state {
                guard let jsonResponse = dataObject as? [String: Any] else {
                    AlertsController().generateAlert(withError: ErrorMessage.parseError)
                    completion(false, ErrorMessage.parseError, [])
                    return
                }
                var storiesOutput = [Story]()
                
                completion(true, message, storiesOutput)
            } else {
                completion(false, message, [])
            }
        }
    }
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
                completion(true, message)
            } else {
                completion(false, message)
            }
        }
    }
}
