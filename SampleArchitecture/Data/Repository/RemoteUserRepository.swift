//
//  RemoteUserRepository.swift
//  SampleArchitecture
//
//  Created by user on 07.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class RemoteUserRepository: UserRepository {

    private let provider = MoyaProvider<UserAPIService>()

    func getData() -> Observable<[User]> {
        return provider.rx
                .request(.getUsers)
                .map {
                    try JSONDecoder().decode([User].self, from: $0.data)
                }
//                .do(onNext: { users in for user in users {
//                    print(user.userTitle)
//                } })
                .asObservable()
                .catchError {
                    Observable.error($0)
                }
    }
}
