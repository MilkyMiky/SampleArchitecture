//
//  UserRepository.swift
//  SampleArchitecture
//
//  Created by user on 07.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository {
    func getUsers() -> Observable<[UserData]>

    func saveUsers(users: [UserData]) -> Completable

    func setDataCompleted(dataId: Int, completed: Bool) -> Observable<UserData>

}
