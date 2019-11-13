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

    func getUserData(dataId: Int) -> Observable<UserData>

    func getUserDataList() -> Observable<[UserData]>

    func saveUserData(users: [UserData]) -> Completable

    func setDataCompleted(dataId: Int, completed: Bool) -> Observable<UserData>

    func removeData(dataId: Int) -> Completable

}
