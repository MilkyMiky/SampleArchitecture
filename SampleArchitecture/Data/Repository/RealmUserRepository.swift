//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift

class RealmUserRepository: UserRepository {
    private let realm = try! Realm()

    func getUsers() -> Observable<[User]> {
        let users = realm.objects(UserRealm.self)
        return Observable.collection(from: users)
                .flatMap { users in
                    self.toDomain(users: users.toArray())
                }
    }

    func saveUsers(users: [User]) -> Completable {
        toRealm(users: users)
                .map { users in
                    try! self.realm.write {
                        self.realm.add(users)
                    }
                }
                .ignoreElements()
    }

    private func toRealm(users: [User]) -> Observable<[UserRealm]> {
        var realm = [UserRealm]()
        for user in users {
            var realmUser = UserRealm()
            realmUser.userTitle = user.userTitle
            realmUser.userId = user.userId
            realmUser.userDataId = user.userDataId
            realmUser.completed = user.completed
            realm.append(realmUser)
        }
        return Observable.just(realm)
    }


    private func toDomain(users: [UserRealm]) -> Observable<[User]> {
        var userList = [User]()
        for realmUser in users {
            userList.append(
                    User(
                            userId: realmUser.userId,
                            userDataId: realmUser.userDataId,
                            userTitle: realmUser.userTitle,
                            completed: realmUser.completed
                    )
            )
        }
        return Observable.just(userList)

    }
}
