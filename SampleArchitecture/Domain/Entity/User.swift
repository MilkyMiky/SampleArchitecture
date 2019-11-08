//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation

struct User: Codable{
    var userId: Int
    var userDataId: Int
    var userTitle: String
    var completed: Bool
}

extension User {
    enum CodingKeys: String, CodingKey {
        case userId
        case userDataId = "id"
        case userTitle = "title"
        case completed
    }
}