//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class RealmUserRepository : UserRepository {
    func getData() -> Observable<[User]> {
        return Observable.just([User]())
    }
}
