//
//  CommentManager.swift
//  FNMotivation
//
//  Created by Michael Amiro on 12/01/2021.
//  Copyright © 2021 Michael Amiro. All rights reserved.
//

import Foundation

class CommentManager {
    func publishComment(storyID: Int, comment: String, completion: @escaping (Bool, String)->()) {
        let parameters: [String: Any] = [
            "message": comment
        ]
        NetworkingService.shared.makeCall(fromUrl: NetworkingValues.apiUrl + "/comments/stories/\(storyID)", networkCallType: .post, requestBody: parameters, headerEnabled: true) { (state, message, dataObject) in
            if state {
                guard let jsonResponse = dataObject as? [String:Any] else {
                    AlertsController().generateAlert(withError: ErrorMessage.parseError)
                    completion(false, ErrorMessage.parseError)
                    return
                }
                completion(true, "Your comment has been posted successfully.")
            } else {
                completion(false, message)
                return
            }
        }
    }
}
