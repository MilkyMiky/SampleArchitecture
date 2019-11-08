//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RealmSwift

class UserRealm : Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var userDataId: Int = 0
    @objc dynamic var userTitle: String = ""
    @objc dynamic var completed: Bool = false
}
