//
// Created by user on 11.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class MarkDataUseCase {
    let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func execute(dataId: Int, completed: Bool) -> Observable<UserData> {
        userService.setDataCompleted(dataId: dataId, completed: completed)
    }
}
