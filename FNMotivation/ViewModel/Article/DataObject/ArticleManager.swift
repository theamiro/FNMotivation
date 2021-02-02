//
//  ArticleManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 08/12/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class ArticleManager {
    func publishArticle(title: String, redirectLink: String, communityID: Int, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "title": title,
            "redirect_link": redirectLink,
            "community_id": communityID
        ]
        NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/posts", networkCallType: .post, requestBody: parameters, headerEnabled: true) { (state, message, dataObject) in
            if state {
                guard let jsonResponse = dataObject as? [String:Any] else {
                    AlertsController().generateAlert(withError: ErrorMessage.parseError)
                    completion(false, ErrorMessage.parseError)
                    return
                }
                completion(true, "Your article has been posted successfully.")
            } else {
                completion(false, message)
                return
            }
        }
    }
}
