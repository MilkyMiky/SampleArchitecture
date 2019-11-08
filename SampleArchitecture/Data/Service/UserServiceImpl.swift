//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class UserServiceImpl: UserService {

    let realmRepo: UserRepository
    let remoteRepo: UserRepository

    init(realmRepo: UserRepository, remoteRepo: UserRepository) {
        self.realmRepo = realmRepo
        self.remoteRepo = remoteRepo
    }

    func getData() -> Observable<[User]> {

        return realmRepo.getData().flatMap { _ in
                    return self.remoteRepo.getData()
                }
    }

}
