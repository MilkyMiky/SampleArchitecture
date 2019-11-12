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

    func refreshUserData() -> Observable<[UserData]> {
        remoteRepo.getUsers()
                .flatMap { users in
                    self.saveUsers(users: users)
                            .andThen(self.realmRepo.getUsers())
                }
    }

    func getUserData() -> Observable<[UserData]> {
        realmRepo.getUsers()
//       remoteRepo.getUsers()
//               .flatMap { users in
//                   self.saveUsers(users: users)
//                           .andThen(self.realmRepo.getUsers())
//               }
    }

    func setDataCompleted(dataId: Int, completed: Bool) -> Observable<UserData> {
        realmRepo.setDataCompleted(dataId: dataId, completed: completed)
    }

    private func saveUsers(users: [UserData]) -> Completable {
        realmRepo.saveUsers(users: users)
    }
}
