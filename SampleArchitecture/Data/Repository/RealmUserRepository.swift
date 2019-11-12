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

    func getUsers() -> Observable<[UserData]> {
        let users = realm.objects(UserDataRealm.self)
        return Observable.collection(from: users)
                .flatMap { users in
                    self.toDomain(users: users.toArray())
                }
    }

    func saveUsers(users: [UserData]) -> Completable {
        toRealm(users: users)
                .map { users in
                    try! self.realm.write {
                        self.realm.delete(self.realm.objects(UserDataRealm.self))
                        self.realm.add(users)
                    }
                }
                .ignoreElements()
    }

    func setDataCompleted(dataId: Int, completed: Bool) -> Observable<UserData> {
        var userDataRealm: UserDataRealm?
        try! realm.write {
            userDataRealm = realm.create(UserDataRealm.self, value: ["userDataId": dataId, "completed": completed], update: .modified)
        }

        return Observable.just(userDataRealm)
                .flatMap { userDataRealm in
                    self.toDomain(users: [userDataRealm!])
                            .map { userDataList in
                                userDataList.first!
                            }
                }
    }

    private func toRealm(users: [UserData]) -> Observable<[UserDataRealm]> {
        var realm = [UserDataRealm]()
        for user in users {
            let realmUser = UserDataRealm()
            realmUser.userTitle = user.userTitle
            realmUser.userId = user.userId
            realmUser.userDataId = user.userDataId
            realmUser.completed = user.completed
            realm.append(realmUser)
        }
        return Observable.just(realm)
    }

    private func toDomain(users: [UserDataRealm]) -> Observable<[UserData]> {
        var userList = [UserData]()
        for realmUser in users {
            userList.append(
                    UserData(
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
