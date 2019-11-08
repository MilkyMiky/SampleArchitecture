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

    func getUsers() -> Observable<[User]> {
       remoteRepo.getUsers()
               .flatMap { users in
                   self.saveUsers(users: users)
                           .andThen(self.realmRepo.getUsers())
               }
    }

    private func saveUsers(users: [User]) -> Completable {
        realmRepo.saveUsers(users: users)
    }
}
