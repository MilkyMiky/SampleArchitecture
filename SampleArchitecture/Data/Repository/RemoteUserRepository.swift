//
//  RemoteUserRepository.swift
//  SampleArchitecture
//
//  Created by user on 07.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class RemoteUserRepository: UserRepository {

    let rxMoyaProvider : RxMoyaProvider<UserAPIService>

    init(rxMoyaProvider: RxMoyaProvider<UserAPIService>) {
        self.rxMoyaProvider = rxMoyaProvider
    }

    func getUserData(dataId: Int) -> Observable<UserData> {
        fatalError("getUserData(dataId:) has not been implemented")
    }

    func getUserDataList() -> Observable<[UserData]> {
        rxMoyaProvider
                .request(.getUsers)
                .map {
                    try JSONDecoder().decode([UserData].self, from: $0.data)
                }
                .asObservable()
                .catchError {
                    Observable.error($0)
                }
    }

    func saveUserData(users: [UserData]) -> Completable {
        fatalError("saveUsers() has not been implemented")
    }

    func setDataCompleted(dataId: Int, completed: Bool) -> Observable<UserData> {
        fatalError("setDataCompleted(completed:) has not been implemented")
    }

    func removeData(dataId: Int) -> Completable {
        fatalError("removeData(dataId:) has not been implemented")
    }
}