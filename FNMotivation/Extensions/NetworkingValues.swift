//
//  NetworkingValues.swift
//  FNMotivation
//
//  Created by Michael Amiro on 12/07/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case posts = "/posts"
    case stories = "/stories"
    case communities = "/communities"
    case notifications = "/notifications"
    case comments = "/comments"
    case login = "/auth/login"
}

class NetworkingValues {
    static let apiUrl = "https://fnmotivation.herokuapp.com/api/v1"
    
    static let termsOfUse = "https://albertfnmotivation.herokuapp.com/api/v1/"
    
}
