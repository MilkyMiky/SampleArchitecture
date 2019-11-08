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

    func getUsers() -> Observable<[User]> {
        rxMoyaProvider
                .request(.getUsers)
                .map {
                    try JSONDecoder().decode([User].self, from: $0.data)
                }
                .asObservable()
                .catchError {
                    Observable.error($0)
                }
    }

    func saveUsers(users: [User]) -> Completable {
        fatalError("saveUsers() has not been implemented")
    }
}