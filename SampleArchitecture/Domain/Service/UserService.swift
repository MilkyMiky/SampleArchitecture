//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol UserService {
    func refreshUserData() -> Observable<[UserData]>

    func getUserDataList() -> Observable<[UserData]>

    func getUserData(dataId: Int) -> Observable<UserData>

    func setDataCompleted(dataId: Int, completed : Bool) -> Observable<UserData>

    func removeData(dataId: Int) -> Completable
}
