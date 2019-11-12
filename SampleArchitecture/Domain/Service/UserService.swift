//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol UserService {
    func getUsers() -> Observable<[UserData]>

    func setDataCompleted(dataId: Int, completed : Bool) -> Observable<UserData>
}
